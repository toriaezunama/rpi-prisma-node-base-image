import { PrismaClient } from "../client";

const { DB_CONNECTION_URL } = process.env;

const prisma = new PrismaClient({
  // Override the datasource defined in schema.prisma
  datasources: {
    db: {
      // 'db' is the name of the datasource in schema.prisma
      url: DB_CONNECTION_URL,
    },
  },
});

async function main() {
  console.log("Creating new tag");
  const newTag = await prisma.tag.create({
    data: {
      name: "Alice",
    },
  });
  console.log(newTag);
  const tags = await prisma.tag.findMany();
  console.log(tags);
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
