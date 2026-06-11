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

CREATE TABLE "Users" (
    "Id" uuid NOT NULL,
    "UserName" text NOT NULL,
    "Email" text NOT NULL,
    "IsEmailVerified" boolean NOT NULL,
    "PasswordHash" text NOT NULL,
    CONSTRAINT "PK_Users" PRIMARY KEY ("Id")
);

CREATE TABLE "RefreshTokens" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "Hash" text NOT NULL,
    "ExpriesAt" timestamp with time zone NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "IsRevoked" boolean NOT NULL,
    CONSTRAINT "PK_RefreshTokens" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_RefreshTokens_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
);

CREATE TABLE "VerifyEmailTokens" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "Code" text NOT NULL,
    "IsRevoked" boolean NOT NULL,
    "ExpiresAt" timestamp with time zone NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_VerifyEmailTokens" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_VerifyEmailTokens_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
);

CREATE TABLE "VerifyRecoveryToken" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "Code" text NOT NULL,
    "IsRevoked" boolean NOT NULL,
    "ExpiresAt" timestamp with time zone NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_VerifyRecoveryToken" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_VerifyRecoveryToken_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
);

CREATE UNIQUE INDEX "IX_RefreshTokens_Hash" ON "RefreshTokens" ("Hash");

CREATE INDEX "IX_RefreshTokens_UserId" ON "RefreshTokens" ("UserId");

CREATE UNIQUE INDEX "IX_Users_Email" ON "Users" ("Email");

CREATE UNIQUE INDEX "IX_Users_UserName" ON "Users" ("UserName");

CREATE INDEX "IX_VerifyEmailTokens_UserId" ON "VerifyEmailTokens" ("UserId");

CREATE INDEX "IX_VerifyRecoveryToken_UserId" ON "VerifyRecoveryToken" ("UserId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20260609142948_Initial', '10.0.7');

COMMIT;

