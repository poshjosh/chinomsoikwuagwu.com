---
path: "./2022/08/10/Modifying-legacy-applications-using-domain-driven-design-DDD.md"
date: "2022-08-10T12:01:46"
title: "Modifying legacy applications using domain driven design (DDD)"
description: "Modifying-legacy-applications-using-domain-driven-design-DDD"
tags: ["domain driven design", "DDD", "domains", "domain model", "entity", "value object", "service object"]
lang: "en-us"
---

### A brief introduction to Domain Driven Design

This article aims to provide an overview of how legacy code could be refactored in line with
Domain Driven design (DDD).

A basic understanding of DDD is required to fully understand this article.

**What is Domain Driven Design (DDD)?**

>Domain-Driven Design is an approach to software development that centers the development on programming a domain model that has a rich understanding of the processes and rules of a domain. The name comes from a 2003 book by Eric Evans that describes the approach through a catalog of patterns.

>At the heart of this was the idea that to develop software for a complex domain, we need to build Ubiquitous Language that embeds domain terminology into the software systems that we build.

>A particularly important part of DDD is the notion of Strategic Design - how to organize large domains into a network of Bounded Contexts

_Source: https://martinfowler.com/bliki/DomainDrivenDesign.html_

**DDD’s Focus**

- **Only apply DDD to those bounded contexts for which DDD will provide value.**

- **Start with the core domain.** The core domain is that domain which provides the most value to your business.

- **Move domain behaviour to the domain model.** For code bases without DDD, the behaviour usually exists in the code (E.g in a controller or service).

### Moving behaviour to the domain model

**Example of a legacy domain model (i.e. a domain model without DDD).**

_Note: some code has been omitted for simplicity_

```java
public class Customer {
	private BigDecimal moneySpent;
	private List<Subscription> subscriptions;

	public Customer() { }

	public BigDecimal getMoneySpent() { return this.moneySpent; }
	public void setMoneySpent(BigDecimal moneySpent) { this.moneySpent = moneySpent; }
	public List<Subscription> getSubscriptions() { return this.subscriptions; }
	public void setSubscriptions(List<Subscription> subscriptions) { this.subscriptions = subscriptions; }
}
```
```java
public class Product { }
```
```java
public enum SubscriptionStatus {
	Active, Cancelled, Suspended
}
```

```java
public class Subscription {

	private SubscriptionStatus status;
	private Customer customer;
	private Product product;
	private BigDecimal amount;

	public Subscription() { }

	public SubscriptionStatus getStatus() { return this.status; }
	public void setStatus(SubscriptionStatus status) { this.status = status; }
	public Customer getCustomer() { return this.customer; }
	public void setCustomer(Customer customer) { this.customer = customer; }
	public Product getProduct() { return this.product; }
	public void setProduct(Product product) { this.product = product; }
	public BigDecimal getAmount() { return this.amount; }
	public void setAmount(BigDecimal amount) { this.amount = amount; }
}
```

**Step 1 - Move construction behaviour**

```java
public class Subscription {

	private final SubscriptionStatus status;
	private final Customer customer;
	private final Product product;
	private final BigDecimal amount;

	public Subscription(Customer customer, Product product, BigDecimal amount) { 
		this.status = SubscriptionStatus.Active;
		this.customer = Objects.requireNonNull(customer);
		this.product = Objects.requireNonNull(product);
		this.amount = requirePositive(amount);
	}

	private boolean requirePositive(BigDecimal amount) {
		if (amount.compareTo(BigDecimal.ZERO) <= 0) {
			throw new IllegalArgumentException("Subscription amount can not be less than or equal zero");
		}
		return amount;
	}

	public SubscriptionStatus getStatus() { return this.status; }
	public Customer getCustomer() { return this.customer; }
	public Product getProduct() { return this.product; }
	public BigDecimal getAmount() { return this.amount; }
}
```

We have removed all setter methods.

We moved the construction behaviour to be part of the domain model. The consumer does not need to concern itself with this behaviour. In addition to other possible improvements, we can no-longer create a Subscription having:

- An invalid initial status (e.g. `Cancelled`).
- A `null` `Product`.
- A `null` `Customer`.

**Step 2 - Move related domain behaviour** 

The `CustomerService` class below is an example of how a legacy application 
(i.e. an application without DDD) may handle the adding of subscription for a customer. 

```java
public class CustomerService {
    
    public Subscription addSubscriptionToCustomer(Customer customer, Product product, BigDecimal amount) {
		Subscription subscription = createSubscription(customer, product, amount);
		customer.getSubscriptions().add(subscription);
		customer.setMoneySpent(customer.getMoneySpent().add(amount));
		return subscription;
    }
}
```

In the above case, developers need to always remember to update amount of money spent by a customer 
every time a subscription is added for a customer. With DDD, we move the adding of a subscription 
to the customer model so that the money spent can be a readonly property of that model. 

```java

import static java.util.Collections.unmodifiableList;

public class Customer {

	private BigDecimal moneySpent = BigDecimal.ZERO;
	private List<Subscription> subscriptions; 

	public Customer() {  }

	public BigDecimal getMoneySpent() { return this.moneySpent; }
	public List<Subscription> getSubscriptions() { unmodifiableList(this.subscriptions); }

	public Subscription addSubscription(Product product, BigDecimal amount) { 
		Subscription subscription = new Subscription(this, product, amount);
		subscriptions.add(subscription);
		moneySpent = moneySpent.add(amount);
	}
}
```

The above code is cleaner from a BDD perspective. For example, consumers no longer need to worry 
about updating the money spent each time a subscription is added for a customer.

Note:

Return an unmodifiable list from the `getSubscriptions()` method above. This protects the 
relation between `moneySpent` and the list of subscriptions a customer has. For example the list of 
subscriptions may only be modified in a way consistent with expected domain behaviour. In particular, 
a developer can not add a subscription without increasing the money spent by the subscription amount.
We achieve this through an `addSubscription` method that takes care of all related changes. This way, 
code like shown below is no longer possible. 

```
customer.getSubscriptions().add(subscription);
```

### How do I know which domain model to move a behaviour to?

- **Consider the properties of the domain model in relation to the behaviour you are trying to move.**

```java
public class CustomerService {

    public Subscription addSubscriptionToCustomer(Customer customer, Product product, BigDecimal amount) {
        Subscription subscription = createSubscription(customer, product, amount);
        customer.getSubscriptions().add(subscription);
        customer.setMoneySpent(customer.getMoneySpent().add(amount));
        return subscription;
    }
}
```

Since the customer model contains a list of subscriptions as well as the money spent, then
it is DDD consistent to have the `addSubscriptionToCustomer` method in the customer model.

- **Consider the method arguments of the method you are trying to move**

```
Instant calculateBillingPeriodEndDate(Product product) {
    // ..        
}
```

The above method could be moved to the `Product` domain model, since it has a single dependency 
i.e. `Product`

- **Consider moving cross-cutting behaviour to a domain service.** If the behaviour does not match any 
of the existing entities, we can move it to a domain service. This is a class that handles 
cross-cutting behaviour. 

Let's go back to our customer service, which we transformed from:

```java
public class CustomerService {

    public Subscription addSubscriptionToCustomer(Customer customer, Product product) {
        BigDecimal amount = calculateSubscriptionAmount(product);
        return addSubscriptionToCustomer(customer, product, amount);
    }

    public Subscription addSubscriptionToCustomer(Customer customer, Product product, BigDecimal amount) {
        Subscription subscription = createSubscription(customer, product, amount);
        customer.getSubscriptions().add(subscription);
        customer.setMoneySpent(customer.getMoneySpent().add(amount));
        return subscription;
    }
    
    private BigDecimal calculateSubscriptionAmount(Product product) {
        //
    }
}
```

to:

```java
public class CustomerService {

    public Subscription addSubscriptionToCustomer(Customer customer, Product product) {
        BigDecimal amount = calculateSubscriptionAmount(product);
        return customer.addSubscription(product, amount);
    }
    
    public BigDecimal calculateSubscriptionAmount(Product product) {
        // ..
    }
}
```

At first glance, it would seem that the method `calculateSubscriptionAmount(Product)` belongs to
the `Product` domain model, because it has a single method argument of type `Product`. However, 
the method returns a subscription amount. This amount, is used to create a `Subscription` for the 
`Customer` domain model. This is a cross-cutting concern: an amount, is created from a `Product` and 
used by a `Customer` `Subscription`. Therefore, we could move the method `calculateSubscriptionAmount(Product)` 
to a `SubscriptionAmountCalculationService`.

Now that we have handled cross-cutting concerns, we can now fully migrate all behaviour related to
adding subscription for a customer to the `Customer` domain model. Here is our updated customer.

```java
public class Customer {
    
    public Subscription addSubscription(Product product, SubscriptionAmountCalculator subscriptionAmountCalculator) {
        BigDecimal amount = subscriptionAmountCalculator.calculateSubscriptionAmount(product);
        Subscription subscription = new Subscription(this, product, amount);
        subscriptions.add(subscription);
        moneySpent = moneySpent.add(amount);
    }
}
```

### Domain Events

What happens if we want to notify the customer after their subscription. This is a kind of 
post subscription action. We can deduce the following requirements for designing such an action:

- The post subscription action needs to be done asynchronously.
- The post subscription action should be decoupled from any particular action (e.g. notifying the 
customer) This way we can specify other actions that may happen post subscription.

The above requirements could be met by the observer pattern using events and event listeners.
Springframework makes using application events easy. Instances of 
`org.springframework.context.ApplicationEvent` may be published by using 
`org.springframework.context.ApplicationEventPublisher`. For example, we could create a
`SubscriptionPersistedEvent` as shown below:

```java
public class SubscriptionPersistedEvent extends org.springframework.context.ApplicationEvent {
    private final Subscription subscription;
    public SubscriptionPersistedEvent(Subscription subscription) {
        this.subscription = java.util.Objects.requireNonNull(subscription);
    }
    public Subscription getSubscription() {
        return this.subscription;
    }
}
```

Each time a subscription is added successfully, we could trigger the event as follows:

```java
public class EventPublicationService {

    private final ApplicationEventPublisher applicationEventPublisher;

    public EventPublicationService(ApplicationEventPublisher applicationEventPublisher) {
        this.applicationEventPublisher = applicationEventPublisher;
    }
    
    public void publishSubscriptionAddedEvent(Subscription subscription) {
        applicationEventPublisher.publishEvent(new SubscriptionPersistedEvent(subscription));
    }
}
```

This event could have any number of listeners, for example:

```java
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class NotifyStakeholdersOnCustomerSubscribed {
    
    private final EmailService emailService;
    
    public NotifyStakeholdersOnCustomerSubscribed(EmailService emailService) {
        this.emailService = emailService;
    }
    
    @EventListener
    public void onSubscriptionPersistedEvent(SubscriptionPersistedEvent subscriptionPersistedEvent) {
        Subscription subscription = subscriptionPersistedEvent.getSubscription();
        emailService.notifyAdmin(subscripton);
        emailService.notifyCustomer(subscripton);
    }
}
```

This way, each time we publish a subscription added event, all listeners get notified.
In this case we have to manually call the method `EventPublicationService.publishSubscriptionAddedEvent(Subscription)`
On the other hand, if we want this method to be called automatically, each time a new `Subscription`
is persisted to the database, then we can rely on java persistence API (JPA) annotations
as shown below:

We first create a `Subscription` listener.

```java
import javax.persistence.PostPersist;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

@Component
public class SubscriptionListener {

    private final ApplicationEventPublisher applicationEventPublisher;
    
    public SubscriptionListener(ApplicationEventPublisher applicationEventPublisher) {
        this.applicationEventPublisher = applicationEventPublisher;
    }
    
    @PostPersist
    private void onSubscriptionPersisted(Subscription subscription) {
        applicationEventPublisher.publishEvent(new SubscriptionPersistedEvent(subscription));
    }
}
```

Then we specify which entity the `SubscriptionListener` applies to.

```java
import javax.persistence.Entity;
import javax.persistence.EntityListeners;

@EntityListeners(SubscriptionListener.class)
@Entity
public class Subscription {
    // ..
}
```

This way, The method annotated with `@PostPersist` will be called each time a new `Subscription` 
is persisted.

### A note on Value Objects

In DDD, value objects differ from entities by lacking the concept of identity. We do not care who 
they are but rather what they are. They are defined by their attributes and should be immutable.

For example, domain experts may refer to contact details. Assuming we do not have a 
`ContactDetails` domain model. We could create a `ContactDetails` value object from, for example,
related `Customer` and `Address` domain models. Similarly, we could create a `CustomerName`
value object from first, middle (other) and last (family) name. 

Two `Customer` entities are equal if their IDs are equal. On the other hand, 2 `CustomerName` value
objects are equal if all their attributes are equal.

### Best practice using Entity IDs

Use a base entity ID. Preferably have strongly typed Ids.

```java
public class EntityId {
    private String id;
    public EntityId(String id) {
        this.id = id;
    }
}
```

```java
public class SubscriptionId extends EntityId{
    public SubscriptionId(String id) {
        super(id);
    }
}
```

Advantages

- We could switch from `String`, to say `Integer` or `UUID` without breaking existing code.
- We are prevented from accidentally using a `CustomerId` in place of a `SubscriptionId`

### References

- [Martin Fownler - Domain Driven Design](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- [YouTube - Practical Domain-Driven-Design with EF Core](https://www.youtube.com/watch?v=yxtsTEhb140)
