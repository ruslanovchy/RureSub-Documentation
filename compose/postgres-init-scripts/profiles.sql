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
    "OccuredAt" timestamp with time zone NOT NULL,
    "ProcessedAt" timestamp with time zone,
    "Error" text,
    CONSTRAINT "PK_OutboxMessages" PRIMARY KEY ("Id")
);

CREATE TABLE "Profiles" (
    "Id" uuid NOT NULL,
    "RedisId" bigint NOT NULL,
    "UserId" uuid NOT NULL,
    "UserName" text NOT NULL,
    "DisplayName" text NOT NULL,
    "Bio" text,
    "AvatarPath" text,
    "BannerPath" text,
    "ShowFollowers" boolean NOT NULL DEFAULT TRUE,
    "ShowFollowings" boolean NOT NULL DEFAULT TRUE,
    "IsVerified" boolean NOT NULL,
    "FollowersCount" integer NOT NULL,
    "FollowingsCount" integer NOT NULL,
    "PostsCount" integer NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_Profiles" PRIMARY KEY ("Id")
);

CREATE UNIQUE INDEX "IX_Profiles_RedisId" ON "Profiles" ("RedisId");

CREATE UNIQUE INDEX "IX_Profiles_UserId" ON "Profiles" ("UserId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20260609152300_Initial', '10.0.7');

COMMIT;

