const fs = require("fs");

function loadVaultSecrets(filePath = "/vault/secrets/config") {
    const secrets = {};

    try {
        const content = fs.readFileSync(filePath, "utf8");

        content.split("\n").forEach((line) => {
            if (!line.trim()) return;

            const [key, ...value] = line.split("=");

            secrets[key.trim()] = value.join("=").trim();
        });

        console.log("Vault secrets loaded successfully.");
    } catch (err) {
        console.log("Vault secrets not found. Falling back to environment variables.");
    }

    return secrets;
}

module.exports = loadVaultSecrets;