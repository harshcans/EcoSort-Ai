const guidance = require("./guidance.json");

function getGuidance(category) {
  return guidance[category] || null;
}

function getCategories() {
  return Object.keys(guidance);
}

module.exports = {
  getGuidance,
  getCategories
};