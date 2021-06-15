### Parking Permits Gateway

Backend repository for parking permits gateway developed by City of Helsinki.

Instructions in this README.md are written with an experienced developer in mind.
For example, "docker-compose up" means you already know what docker and docker-compose are
and you already have both installed locally. This helps to keep the README.md concise.

### Architecture overview

Gateway is implemented using [Apollo Federation architecture](https://www.apollographql.com/docs/federation/#architecture):

```
An Apollo Federation architecture consists of:

- A collection of subgraphs (usually represented by different back-end services) that each define a distinct GraphQL schema

- A gateway that composes the subgraphs into a federated data graph and executes queries across multiple subgraphs
```

Our gateway composes the following subgraphs:

1. [parking-permits](https://github.com/City-of-Helsinki/parking-permits)
2. [open-city-profile](https://github.com/City-of-Helsinki/open-city-profile) **TO BE DONE**

### Setting up local development environment with Docker

- Clone the repository

- Start the application

  ```bash
  docker-compose up
  ```

- Access development server on [localhost:3333](http://localhost:3333)

- Done!
