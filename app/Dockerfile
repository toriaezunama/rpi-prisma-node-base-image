FROM prisma-arm32v7:node-14

RUN mkdir /app
WORKDIR /app

# Install prisma cli
COPY package.json .
RUN npm install

# Copy in schema
COPY schema.prisma .

# Generate prisma client
RUN prisma generate

# Copy src
COPY tsconfig.json .
COPY src src

ENTRYPOINT ["npm" "run" "start"]
