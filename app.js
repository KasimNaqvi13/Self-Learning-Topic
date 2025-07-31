const express = require('express');
const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());
const PORT = 8000;

// Webhook endpoint
app.post('/webhook/businesscentral', (req, res) => {
    // Handle validation handshake
    if (req.query && req.query.validationtoken) {
        res.status(200).send(req.query.validationtoken);
        return;
    }
    // Log webhook notifications
    console.log('Webhook Notification:', JSON.stringify(req.body, null, 2));
    res.status(200).send('Notification received');
});

// For webhook validation, Business Central will call this via GET
app.get('/webhook/businesscentral', (req, res) => {
    if (req.query && req.query.validationtoken) {
        res.status(200).send(req.query.validationtoken);
        return;
    }
    res.status(200).send('OK');
});

app.listen(PORT, () => {
    console.log(`Webhook endpoint listening on port ${PORT}`);
});
