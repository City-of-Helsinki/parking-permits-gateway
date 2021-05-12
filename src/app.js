const { ApolloGateway } = require("@apollo/gateway");
const { ApolloServer } = require("apollo-server");

const PORT = process.env.PORT || "3000";
const PARKING_PERMITS_GRAPHQL_API = process.env.PARKING_PERMITS_GRAPHQL_API;

const federatedServices = [
  { name: "parking-permits", url: PARKING_PERMITS_GRAPHQL_API },
];

const gateway = new ApolloGateway({ serviceList: federatedServices });
const server = new ApolloServer({ gateway, subscriptions: false });

server.listen(PORT).then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
