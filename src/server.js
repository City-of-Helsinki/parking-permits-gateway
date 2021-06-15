const { gateway } = require("./gateway.js");
const { ApolloServer } = require("apollo-server");

const PORT = process.env.PORT || "3333";

const server = new ApolloServer({
  gateway,
  subscriptions: false,
  context: ({ req }) => req,
});

server.listen(PORT).then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
