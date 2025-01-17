/*
  Warnings:

  - You are about to drop the `_PokemonCardToType` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `typeId` to the `PokemonCard` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "_PokemonCardToType_B_index";

-- DropIndex
DROP INDEX "_PokemonCardToType_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_PokemonCardToType";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PokemonCard" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "pokedexId" INTEGER NOT NULL,
    "typeId" INTEGER NOT NULL,
    "lifePoints" INTEGER NOT NULL,
    "size" REAL,
    "weight" REAL,
    "imageUrl" TEXT,
    CONSTRAINT "PokemonCard_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "Type" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_PokemonCard" ("id", "imageUrl", "lifePoints", "name", "pokedexId", "size", "weight") SELECT "id", "imageUrl", "lifePoints", "name", "pokedexId", "size", "weight" FROM "PokemonCard";
DROP TABLE "PokemonCard";
ALTER TABLE "new_PokemonCard" RENAME TO "PokemonCard";
CREATE UNIQUE INDEX "PokemonCard_name_key" ON "PokemonCard"("name");
CREATE UNIQUE INDEX "PokemonCard_pokedexId_key" ON "PokemonCard"("pokedexId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
