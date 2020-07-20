const fs = require('fs').promises;
const addresses = require('/tmp/addresses.json');
const axios = require('axios');

const TARGET_DIR = '/MOAP-Backend';
const configSamplePath = `${TARGET_DIR}/ecosystem.config.js.sample`;
const configPath = `${TARGET_DIR}/ecosystem.config.js`;

const masterAccount = addresses.nemesis_addresses[0];
const storeAccount = addresses.nemesis_addresses[1];
//const GENERATION_HASH_URL = 'http://localhost:3000/blocks/1';
const GENERATION_HASH_URL = 'http://host.docker.internal:3000/blocks/1';

const proc = async () => {
  let config = (await fs.readFile(configSamplePath)).toString();

  config = config.replace(
    /STORE_ADDR: '.*'/,
    `STORE_ADDR: '${storeAccount.address}'`,
  );
  config = config.replace(
    /STORE_PUB_KEY: '.*'/,
    `STORE_PUB_KEY: '${storeAccount.public}'`,
  );
  config = config.replace(
    /STORE_PRIV_KEY: '.*'/,
    `STORE_PRIV_KEY: '${storeAccount.private}'`,
  );
  config = config.replace(
    /MASTER_PRIV_KEY: '.*'/,
    `MASTER_PRIV_KEY: '${masterAccount.private}'`,
  );

  const { data } = await axios.get(GENERATION_HASH_URL);
  if (data?.meta?.generationHash) {
    config = config.replace(
      /GENERATION_HASH: '.*'/,
      `GENERATION_HASH: '${data.meta.generationHash}'`,
    );
  } else {
    console.error('NEMブロックチェーンのGenerationHash取得に失敗しました。');
    console.error(
      GENERATION_HASH_URL,
      でGenerationHashが取得できることを確認してください,
    );
  }

  fs.writeFile(configPath, config);
};

proc();
