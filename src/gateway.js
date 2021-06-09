const { ApolloGateway } = require("@apollo/gateway");

const OPEN_CITY_PROFILE_GRAPHQL_API = process.env.OPEN_CITY_PROFILE_GRAPHQL_API;
const PARKING_PERMITS_GRAPHQL_API = process.env.PARKING_PERMITS_GRAPHQL_API;

const federatedServices = [
  { name: "open-city-profile", url: OPEN_CITY_PROFILE_GRAPHQL_API },
  { name: "parking-permits", url: PARKING_PERMITS_GRAPHQL_API },
];

const gatewayOptions = { serviceList: federatedServices };

const gateway = new ApolloGateway(gatewayOptions);

module.exports = {
  gateway,
};
