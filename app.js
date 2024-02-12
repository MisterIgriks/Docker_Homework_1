import chalk from 'chalk';
import dotenv from 'dotenv';
import express from 'express';
import { v4 as uuidv4 } from 'uuid';

dotenv.config();

const app = express();

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.get('/uuid', (req, res) => {
  const generatedUuid = uuidv4();
       
  res.json({ uuid: generatedUuid });
});

app.get('/healthz', (req, res) => {
  res.send('OK');
});

const port = process.env.PORT || 3000;

app.set('view engine', 'ejs').listen(port, error => {
  if (error) {
    console.log(chalk.bgWhite.red(error));
  } else {
    console.log(chalk.bgGreen.white(`Server running on http://192.168.0.99:${port}`));
  }
});

