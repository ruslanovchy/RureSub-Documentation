CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;
CREATE TABLE "InboxMessages" (
    "Id" uuid NOT NULL,
    "Topic" text NOT NULL,
    "Content" text,
    "ProcessedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_InboxMessages" PRIMARY KEY ("Id")
);

CREATE TABLE "OutboxMessages" (
    "Id" uuid NOT NULL,
    "Topic" text NOT NULL,
    "Content" text NOT NULL,
    "OccuredOn" timestamp with time zone NOT NULL,
    "ProcessedOn" timestamp with time zone,
    "Error" text,
    CONSTRAINT "PK_OutboxMessages" PRIMARY KEY ("Id")
);

CREATE TABLE "Posts" (
    "Id" uuid NOT NULL,
    "AuthorId" uuid NOT NULL,
    "Title" text NOT NULL,
    "Content" jsonb,
    "IsEdited" boolean NOT NULL,
    "PostedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_Posts" PRIMARY KEY ("Id")
);

CREATE TABLE "MediaFiles" (
    "Id" uuid NOT NULL,
    "PostId" uuid NOT NULL,
    "Path" text,
    "Type" text,
    CONSTRAINT "PK_MediaFiles" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_MediaFiles_Posts_PostId" FOREIGN KEY ("PostId") REFERENCES "Posts" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_MediaFiles_PostId" ON "MediaFiles" ("PostId");

CREATE INDEX "IX_Posts_AuthorId" ON "Posts" ("AuthorId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20260609154245_Initial', '10.0.8');

COMMIT;


