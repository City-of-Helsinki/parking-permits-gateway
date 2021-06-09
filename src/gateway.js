const { ApolloGateway, RemoteGraphQLDataSource } = require("@apollo/gateway");

const OPEN_CITY_PROFILE_GRAPHQL_API = process.env.OPEN_CITY_PROFILE_GRAPHQL_API;
const PARKING_PERMITS_GRAPHQL_API = process.env.PARKING_PERMITS_GRAPHQL_API;

const federatedServices = [
  { name: "open-city-profile", url: OPEN_CITY_PROFILE_GRAPHQL_API },
  { name: "parking-permits", url: PARKING_PERMITS_GRAPHQL_API },
];

class CustomGraphQLDataSource extends RemoteGraphQLDataSource {
  // CustomGraphQLDataSource represents a connection between the gateway and each of federatedServices
  // We override willSendRequest to modify the gateway's requests to the federatedServices before they're sent

  willSendRequest({ request, context }) {
    request.http.headers.set("authorization", context.headers?.authorization);
  }
}

function buildService({ url }) {
  return new CustomGraphQLDataSource({ url });
}

const gatewayOptions = {
  serviceList: federatedServices,
  buildService: buildService,
};

const gateway = new ApolloGateway(gatewayOptions);

module.exports = {
  gateway,
};
