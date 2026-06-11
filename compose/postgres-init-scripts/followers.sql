CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;
CREATE TABLE "OutboxMessages" (
    "Id" uuid NOT NULL,
    "Topic" text NOT NULL,
    "Content" text NOT NULL,
    "OccuredAt" timestamp with time zone NOT NULL,
    "ProcessedAt" timestamp with time zone,
    "Error" text,
    CONSTRAINT "PK_OutboxMessages" PRIMARY KEY ("Id")
);

CREATE TABLE "Subscriptions" (
    "FollowerId" uuid NOT NULL,
    "FollowingId" uuid NOT NULL,
    "Id" uuid NOT NULL,
    "FollowedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_Subscriptions" PRIMARY KEY ("FollowerId", "FollowingId"),
    CONSTRAINT "CK_Not_Self_Follow" CHECK ("FollowerId" <> "FollowingId")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20260606185536_Initial', '10.0.8');

COMMIT;

