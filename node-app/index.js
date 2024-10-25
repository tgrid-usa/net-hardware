// index.js
const express = require('express');
const { v4: uuidv4 } = require('uuid');
const path = require('path');
const chalk = require('chalk');

const app = express();
const port = 3000;

// Store logs in memory
let logs = [];

// Create rainbow colors array
const rainbowColors = [
    chalk.red,
    chalk.yellow,
    chalk.green,
    chalk.cyan,
    chalk.blue,
    chalk.magenta
];

// Function to get next color in rainbow cycle
let colorIndex = 0;
function getNextColor() {
    const color = rainbowColors[colorIndex];
    colorIndex = (colorIndex + 1) % rainbowColors.length;
    return color;
}

// Logger function to generate random logs
function generateLog() {
    const statements = [
        '|INFO|Synching Ledger',
        '|INFO|Synching node',
        '|INFO|Validating DID',
        `|INFO|Ordering_service.py| Node:${Math.floor(Math.random() *10)} set last ordered as (${Math.floor(Math.random() *199)}, ${Math.floor( Math.random() *1000)})`,
    ];
    
    const randomStatement = statements[Math.floor(Math.random() * statements.length)];
    const uuid = uuidv4();
    const timestamp = new Date().toISOString();
    
    const log = {
        id: uuid,
        statement: randomStatement,
        timestamp: timestamp
    };
    
    logs.push(log);

    // Create rainbow log message
    const timestampColor = getNextColor();
    const statementColor = getNextColor();
    const uuidColor = getNextColor();

    console.log(
        `${timestampColor(timestamp)} - ${statementColor(randomStatement)} - ${uuidColor(uuid)}`
    );
    
    // Generate next log after random time (1-5 seconds)
    const nextInterval = Math.floor(Math.random() * 4000) + 1000; // Random between 1-5 seconds
    setTimeout(generateLog, nextInterval);
}

// Start the logger
generateLog();

// API Routes
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/logs', (req, res) => {
    res.json(logs);
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});