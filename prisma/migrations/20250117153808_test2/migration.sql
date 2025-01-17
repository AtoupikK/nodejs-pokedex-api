/*
  Warnings:

  - You are about to drop the column `typeId` on the `PokemonCard` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "_PokemonCardToType" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_PokemonCardToType_A_fkey" FOREIGN KEY ("A") REFERENCES "PokemonCard" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_PokemonCardToType_B_fkey" FOREIGN KEY ("B") REFERENCES "Type" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PokemonCard" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "pokedexId" INTEGER NOT NULL,
    "lifePoints" INTEGER NOT NULL,
    "size" REAL,
    "weight" REAL,
    "imageUrl" TEXT
);
INSERT INTO "new_PokemonCard" ("id", "imageUrl", "lifePoints", "name", "pokedexId", "size", "weight") SELECT "id", "imageUrl", "lifePoints", "name", "pokedexId", "size", "weight" FROM "PokemonCard";
DROP TABLE "PokemonCard";
ALTER TABLE "new_PokemonCard" RENAME TO "PokemonCard";
CREATE UNIQUE INDEX "PokemonCard_name_key" ON "PokemonCard"("name");
CREATE UNIQUE INDEX "PokemonCard_pokedexId_key" ON "PokemonCard"("pokedexId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "_PokemonCardToType_AB_unique" ON "_PokemonCardToType"("A", "B");

-- CreateIndex
CREATE INDEX "_PokemonCardToType_B_index" ON "_PokemonCardToType"("B");
