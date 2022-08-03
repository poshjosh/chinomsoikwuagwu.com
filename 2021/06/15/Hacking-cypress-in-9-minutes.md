---
path: "./2021/06/15/Hacking-cypress-in-9-minutes.md"
date: "2021-06-15T12:00:38"
title: "Hacking Cypress in 9 minutes"
description: "Ten best practices when using gherkin syntax"
tags: ["cypress", "e2e"]
lang: "en-us"
---

### Cypress - Hacking it in 9 minutes

**Install Cypress**

```sh
npm install -D cypress
```

The above command installs Desktop App and CLI

To open the Desktop App

```sh
npx cypress open 
```

The above works because the Desktop App is a binary in your node_modules

```
My Project
    Cypress
	fixtures
	integration (will contain your test files)
	plugins
	support
```

In the Cypress GUI, click on any test.spec.js file to run it

**Example Basic Test Spec**

```js
cy.get('button').click().should('have.class', 'active')
```

The above command will automatically wait (default = 4secs)

```js
cy.request('/users/1').its('body').should('deep.eql', {name:'Amir'})
```

```js
it('login user', () => {
    cy.visit('http://localhost:8080/signup')

    cy.get('input[name=“email”]').type('amir@cypress.io')
    cy.get('input[name=“password”]').type('123456')
    cy.get('#login-button').click()

    // After login the user should direct to /home
    cy.location('pathname').should('eq', '/home')

})
```

**Custom commands**

Declare custom commands in the commands file in the support directory `cypress/support/commands.js`

```js
// cypress/support/commands.js

Cypress.Commands.add('login', (email, password) => {
    cy.get('input[name=“email”]').type(email)
    cy.get('input[name=“password”]').type(password)
    cy.get('#login-button').click()
})
```

After defining the custom command above, use it this way

```js
cy.login('amir@cypress.io', '123456')
```

**Tasks**

Custom tasks could be defined e.g to clear seed and/clear test data

```js
// cypress/plugins/index.js

const { seedDatabase, clearDatabase } = require('../../server/db')

module.exports = (on, config) => {
  on('task', {
    'seed:db', (data) => seedDatabase() // can accept arguments
  })

  on('task', {
    'clear:db', () => clearDatabase()
  })
}
```

Use the declared task

```js
const userSeed = require('../../server/seed/users')

context('User setup', () => {
    beforeEach(() => {
        cy.task('clear:db')
        cy.task('seed:db', userSeed.data)
    })

    it('login user', () => {
        cy.visit('http://localhost:8080/login')
        cy.login('amir@cypress.io', '123456')
        cy.location('pathname').should('eq', '/board')
    })
})

```

**More on custom commands**

We could add a programmatic implementation of our earlier login command to make the login process even more efficient.

```js
// cypress/support/commands.js

// We rename the earlier login command to 'loginWithUI'
Cypress.Commands.add('loginWithUI', (email, password) => {
    cy.get('input[name=“email”]').type(email)
    cy.get('input[name=“password”]').type(password)
    cy.get('#login-button').click()
})

// login programmatically
Cypress.Commands.add('login', (email, password) => {
    return cy.window().then(win => {
        return win.app.$store.dispatch('login', {
            email: 'amir@cypress.io',    
            password: '123456',    
        }) 
    }) 
})
```

Notes:

- Cypress has programmatic access to our app
- We can directly call the function that does the login within our application
- We achieve this by attaching an instance of our app to the global window of the browser
- We then use window command of Cypress to access the global app instance.
- The central state management of the application (in this case Vuex) is used to dispatch the login functionality directly i.e `$store.dispatch`

**Stubbing network response with fixtures**

Define fixture e.g in `cypress/fixtures/tweets.json`

```js
const userSeed = require('../../server/seed/users')

context('Tweet Loading', () => {
    beforeEach(() => {
        cy.task('clear:db')
        cy.task('seed:db', userSeed.data)
        cy.visit('http://localhost:8080/login')
        cy.login('amir@cypress.io', '123456')
    })

    // stub network response with a fixture
    it('load tweets for selected hashtags', () => {
        cy.server() // stub a server
  
        // Define what happens when a call is made to GET /tweets
        cy.route('GET', '/tweets*', 'fixture:tweets') 
            .as('tweets') // label the route to be able to refer to it elsewhere

        // drive the input box        
        cy.get('#hashtags').type('javascript{enter}').type('cypressio{enter}')

       // wait for the response to return
        cy.window().then(win => {
            cy.wait('@tweets') // Refer to the labelled route
                .its('response.body.tweets')
                .should('have.length', win.app.$store.state.tweets.length)
        })
    })
})
```

Simulate slow response/error scenarios

```js
const userSeed = require('../../server/seed/users')

context('Tweet Loading', () => {
    beforeEach(() => {
        cy.task('clear:db')
        cy.task('seed:db', userSeed.data)
        cy.visit('http://localhost:8080/login')
        cy.login('amir@cypress.io', '123456')
    })

    // stub network response with a fixture
    it('load tweets for selected hashtags', () => {
        cy.server() // stub a server
  
        cy.fixture('tweets').then(tweets => {
            cy.route({
                url: '/tweets*',
                response: '/tweets*',
                delay: 3000, // simulate slow response
                status: 404,   // simulate error scenarios
            })
        }).as('tweets')
    })
})
```

In the earlier example we used a fixture via the route command with a string pattern `fixture:tweets`

In this example we are using the cypress `cy.fixture` command

**Headless mode**

Outside of Cypress Desktop App, for example from within a CI pipeline

```shell
npx cypress run
```

In headless mode, we get automatic video recordings of our tests

In a nutshell, use:

`npx cypress open` - for UI mode i.e desktop app
`npx cupress run` - for headless mode

**Cypress dashboard**

To record results to the cypress dashboard, use the `--record` option.

```shell
npx cypress run --record
```

**Optimize CI Usage with parallelization**

Cypress will optimally figure out how to load balance your test files across your ci machines

```shell
npx cypress run --record --parallel
```

**Learn more**

- [Recipes](https://docs.cypress.io/examples/examples/recipes)

- [Real world example](https://github.com/cypress-io/cypress-realworld-app)

**Reference**

- [Cypress Docs - Why Cypress](https://docs.cypress.io/guides/overview/why-cypress)


