---
path: "./2022/03/25/Gherkin-best-practices.md"
date: "2022-03-25T12:04:27"
title: "Gherkin Best Practices"
description: "Ten best practices when using gherkin syntax"
tags: ["gherkin", "best practices", "domain specific language", "behavior driven design", "BDD"]
lang: "en-us"
---

### Gherkin Best Practices

Gherkin is a Business Readable, Domain Specific Language created especially for behavior descriptions.
It gives you the ability to remove logic details from behavior tests. Gherkin serves both to define automated tests, and to document a project's expected behavior. In Gherkin, a `scenario` is used
to document and test each expected behavior. It is important to remember that scenarios are more than
tests; they also represent requirements and acceptance criteria.

**Rules of Thumb**

1. Write Declarative Features

Imperative testing/programming involves essentially spelling out in detail how to accomplish something.

![BAD](./check-bad.png)

```gherkin
Given I open a browser
And I navigate to https://mywebsite.com/login
```

Declarative testing/programming involves only specifying what needs to be accomplished.

![GOOD](./check-good.png)

```gherkin
Given I am on the login page
```

2. Cover One Behavior per Scenario.

![BAD](./check-bad.png)

```gherkin
Scenario: Should let me select payment options in the checkout process
    Given I am logged in as upp-e2e-test
    Then I go to the checkout units and cost types page
    When I click continue checkout process
    Then I go to the checkout addresses page
    When I click continue checkout process
    Then I am on the checkout payment page
    And payment and invoice notification method selection are visible
    When the direct debit payment option is selected
    Then additional information will be displayed
    When I select another payment method
    Then additional information will not be displayed
    When I click continue checkout process
    Then I am on the checkout overview page
```

:warning: The above scenario tests multiple behaviours. Each `when -> then` statement tests a behavior, and thus violates the behavior per scenario principle.

![GOOD](./check-good.png)

```gherkin
Scenario: Display additional information for direct debit payment method
    Given BANFer user is on the checkout payment page
    When the user selects direct debit payment option
    Then additional information is displayed
```

3. Respect the Integrity of Step Types:

- **Usage.** Use each step as follows:

    - `Given` - Set up initial state.
    - `When` - Perform an action.
    - `Then` - Verify outcome(s).

- **Order.** `Given-When-Then` steps must appear in this order.
    - A `Given` may not follow a `When` or a `Then`
    - A `When` may not follow a `Then`

4. Each Step should be Written as a Subject-Predicate Phrase:

![BAD](./check-bad.png)

```gherkin
Scenario: Product search result page views
    Given the user navigates to the UPP home page
    When the user searches for "copy paper"
    Then the results page shows links related to "copy paper"
    And producer-view links related to "copy paper"
```

:warning: In the above scenario, the final `And` step is not written as a subject-predicate phrase and is more likely to be reused improperly. For instance, what are the answers to the following questions:

- What is "producer-view links related to "copy paper"" doing?
- Are the _links_ meant to be the subjects, meaning that they perform some action, or are they some objects actually receiving the action?

The following snippet shows the corrected version of the above scenario:

a. It splits the scenario following the "Cover One Behavior per Scenario" recommendation, and
b. fixes the subject-predicate phrase issue in the `And` statement.

![GOOD](./check-good.png)

```gherkin
Feature: Product search

  Scenario: Basic product search
      Given the user is on the UPP home page
      When the user searches for "copy paper"
      Then the results page shows links related to "copy paper"

  Scenario: Producer-view links in product search result
      Given the user is on the UPP home page
      When the user searches for "copy paper"
      Then the results page shows producer-view links related to "copy paper"
```

5. Don't use Action Statements in the `Given` Step

`Given` statements are supposed to establish an initial state, and thus should not exercise behavior.

![BAD](./check-bad.png)

```gherkin
Scenario: Product search
    Given the user navigates to the UPP home page
```

![GOOD](./check-good.png)

```gherkin
Scenario: Product search
    Given the user is on the UPP home page
```

6. Hide Data in the Automation

![BAD](./check-bad.png)

```gherkin
Scenario: Log in
    Given I have opened my Browser on "http://example.com/login"
    When I login with username “Joe” and password “Secret”
    Then I should be redirected to "http://example.com"
    And the page should contain “Joe”
    And "LoggedIn" should be “true”
```

![GOOD](./check-good.png)

```gherkin
Scenario: Log in
    Given I am on the login page
    When I log in
    Then I should be greeted with my name
```

7. Don't mix First-person and Third-person

![BAD](./check-bad.png)

```gherkin
Scenario: Product search
    Given I am on the UPP home page
    When the user searches for "copy paper"
    Then Then I see links related to "copy paper"
```

:warning: The above scenario is confusing. Am I `the user`, or is `the user` a different person? Should there be a second browser for `the user`? Why do I see what `the user` sees? The English is poorly written due to the mixed point of view.

![GOOD](./check-good.png)

```gherkin
Scenario: Product search
    Given I am on the UPP home page
    When I search for "copy paper"
    Then Then I see links related to "copy paper"
```

8. Prefer Third-person to First-person

![GOOD](./check-good.png)

```gherkin
Scenario: Product search
    Given the user is on the UPP home page
    When the user searches for "copy paper"
    Then the results page shows links related to "copy paper"
```

9. Use Present Tense

![BAD](./check-bad.png)

```gherkin
Scenario: Product search
    Given the user is on the UPP home page
    When the user searched for "copy paper"
    Then the results page will show links related to "copy paper"
```

:warning: The `When` step above uses past tense when it says, `“The user searched.”` This indicates that an action has already happened. However, `When` steps should indicate that an action is presently happening. Plus, past tense here conflicts with the tenses used in the other steps. The `Then` step above uses future tense when it says, `“The results will show.”` Future tense seems practical for `Then` steps because it indicates what the result should be after the current action is taken. However, future tense reinforces a procedure-driven approach because it treats the scenario as a time sequence. A behavior, on the other hand, is a present-tense aspect of the product or feature. Thus, it is better to write `Then` steps in the present tense.

![GOOD](./check-good.png)

```gherkin
Scenario: Product search
    Given the user is on the UPP home page
    When the user searches for "copy paper"
    Then the results page shows links related to "copy paper"
```

10. Avoid Conjunctive Steps

When you encounter a Cucumber step that contains two actions joined with an “and”, you should probably break it into two steps.
Sticking to one action per step makes your steps more modular and increases re-usability.

![BAD](./check-bad.png)

```gherkin
Scenario: Display additional information for direct debit payment method
    Given BANFer user is on the checkout payment page and payment and invoice notification method selection are visible
    When the user selects direct debit payment option
    Then additional information is displayed
```

![GOOD](./check-good.png)

```gherkin
Scenario: Display additional information for direct debit payment method
    Given BANFer user is on the checkout payment page
    And payment related options are visible
    When the user selects direct debit payment option
    Then additional information is displayed
```

**Other Considerations**

- **Traceability.** For traceability, each scenario should be limited to: `1 behavior → 1 example → 1 scenario → 1 test → 1 result`
- **Use backgrounds wisely.** If you use the same steps at the beginning of all scenarios of a feature, put them into the feature’s Background.
  Background steps are run before each scenario.
  But take care that you don’t put too many steps in there as your scenarios may become hard to understand.
- **Avoid Assertion Language.** Don’t use the words “verify,” “assert,” or “should” in scenario titles. They put the scenario’s emphasis on the assertion rather than the behavior. Assertions are merely a facet of behavior testing – they verify that something exists or that two values are equal. Behavior scenarios, however, are full software specifications.
- **Good titles should be short one-liners.** One simple statement should be sufficient to concisely capture the intended behavior. Anything longer likely means that either the author doesn’t truly understand the behavior in focus, or that the scenario does not focus on one main behavior. Extra comments may be added to supplement the scenario’s description if necessary to avoid lengthy titles.

**Useful Links**

- [Gherkin syntax](https://cucumber.io/docs/gherkin/)
- [Gherkin anti-patterns](https://cucumber.io/docs/guides/anti-patterns/)
- [ATDD/BDD anti-patterns](http://www.thinkcode.se/blog/2016/06/22/cucumber-antipatterns)
- [Cypress best practices](https://docs.cypress.io/guides/references/best-practices)
