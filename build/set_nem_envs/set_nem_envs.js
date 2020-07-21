const fs = require('fs').promises;
const axios = require('axios');
const yaml = require('yaml');

const ENV_PATH = '/.env';
const YML_PATH = '/addresses.yaml';
const GENERATION_HASH_URL = 'http://host.docker.internal:3000/blocks/1';

const readFile = (path) => fs.readFile(path).then((buf) => buf.toString());

const proc = async () => {
  const addresses = yaml.parse(await readFile(YML_PATH));

  const masterAccount = addresses.nemesis_addresses[0];
  const storeAccount = addresses.nemesis_addresses[1];

  let config = await readFile(ENV_PATH);

  config += `STORE_ADDR=${storeAccount.address}\n`;
  config += `STORE_PUB_KEY=${storeAccount.public}\n`;
  config += `STORE_PRIV_KEY=${storeAccount.private}\n`;
  config += `MASTER_PRIV_KEY=${masterAccount.private}\n`;

  const { data } = await axios.get(GENERATION_HASH_URL);
  if (data?.meta?.generationHash) {
    config += `GENERATION_HASH=${data.meta.generationHash}\n`;
  } else {
    console.error('NEMブロックチェーンのGenerationHash取得に失敗しました。');
    console.error(
      GENERATION_HASH_URL,
      でGenerationHashが取得できることを確認してください,
    );
  }

  fs.writeFile(ENV_PATH, config);
};

proc();
