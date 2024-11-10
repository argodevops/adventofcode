const fs = require('fs');

class FileReader {
    constructor(filePath) {
        this.filePath = filePath;
    }

    readLines() {
        try {
            const data = fs.readFileSync(this.filePath, 'utf8');
            return data.split('\n').map(line => line.trim());
        } catch (err) {
            console.error(`Error reading file ${this.filePath}:`, err.message);
            return [];
        }
    }
}

module.exports = FileReader;
