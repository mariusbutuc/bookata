# A simple Node.js application that we'll build and run using Docker.
# This pattern works for other interpreted languages like Ruby, Python, and PHP.

FROM diamol/node AS builder

WORKDIR /src
COPY src/package.json .

RUN npm install

# app
FROM diamol/node

EXPOSE 80
CMD ["node", "server.js"]

WORKDIR /app
COPY --from=builder /src/node_modules/ /app/node_modules/
COPY src/ .
