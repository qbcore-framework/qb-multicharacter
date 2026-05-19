/**
 * Validation utility for QB-Multicharacter
 * Handles character creation validation logic
 */

class CharacterValidator {
  constructor(profanityRegex) {
    this.profanityRegex = profanityRegex;

    this.validators = {
      firstname: [
        { test: (value) => !!value, message: "forgotten_field" },
        { test: (value) => value.length >= 2, message: "firstname_too_short" },
        { test: (value) => value.length <= 16, message: "firstname_too_long" },
        { test: (value) => !this.profanityRegex.test(value), message: "profanity" },
      ],
      lastname: [
        { test: (value) => !!value, message: "forgotten_field" },
        { test: (value) => value.length >= 2, message: "lastname_too_short" },
        { test: (value) => value.length <= 16, message: "lastname_too_long" },
        { test: (value) => !this.profanityRegex.test(value), message: "profanity" },
      ],
      nationality: [
        { test: (value) => !!value, message: "forgotten_field" },
        { test: (value) => !this.profanityRegex.test(value), message: "profanity" },
      ],
      gender: [{ test: (value) => !!value, message: "forgotten_field" }],
      date: [
        { test: (value) => !!value, message: "forgotten_field" },
        { test: (value) => this.isValidDate(value), message: "invalid_date" },
        // enforce age range: min 8 years, max 100 years
        { test: (value) => !this.isTooYoung(value, 8), message: "age_too_young" },
        { test: (value) => !this.isTooOld(value, 100), message: "age_too_old" },
      ],
    };
  }

  /**
   * Validate a complete character form
   * @param {Object} character - Character data object
   * @returns {Object} Result with isValid flag and any error message
   */
  validateCharacter(character) {
    for (const field in this.validators) {
      if (this.validators.hasOwnProperty(field)) {
        const result = this.validateField(field, character[field]);
        if (!result.isValid) {
          return result;
        }
      }
    }
    return { isValid: true };
  }

  /**
   * Validate a single field
   * @param {string} fieldName - Name of the field to validate
   * @param {string} value - Value to validate
   * @returns {Object} Result with isValid flag and any error message
   */
  validateField(fieldName, value) {
    const fieldValidators = this.validators[fieldName];
    if (!fieldValidators) return { isValid: true };

    for (const validator of fieldValidators) {
      if (!validator.test(value)) {
        return { isValid: false, field: fieldName, message: validator.message };
      }
    }
    return { isValid: true };
  }

  // ----- date helpers -----
  parseISODate(dateString) {
    const [y, m, d] = (dateString || "").split("-").map(Number);
    if (!y || !m || !d) return new Date("Invalid Date");
    return new Date(Date.UTC(y, m - 1, d)); // UTC midnight
  }

  todayUTC() {
    const now = new Date();
    return new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()));
  }

  isTooYoung(dateString, minYears = 8) {
    const dob = this.parseISODate(dateString);
    if (isNaN(dob)) return true;
    const today = this.todayUTC();
    const cutoff = new Date(Date.UTC(today.getUTCFullYear() - minYears, today.getUTCMonth(), today.getUTCDate()));
    return dob > cutoff; // later than (today - minYears)
  }

  isTooOld(dateString, maxYears = 100) {
    const dob = this.parseISODate(dateString);
    if (isNaN(dob)) return true;
    const today = this.todayUTC();
    const cutoff = new Date(Date.UTC(today.getUTCFullYear() - maxYears, today.getUTCMonth(), today.getUTCDate()));
    return dob < cutoff; // earlier than (today - maxYears)
  }

  /**
   * Strict calendar validation
   * Accepts only real dates; age bounds handled separately
   */
  isValidDate(dateString) {
    if (!/^\d{4}-\d{2}-\d{2}$/.test(dateString)) return false;
    const [y, m, d] = dateString.split("-").map(Number);
    const date = new Date(y, m - 1, d);
    return (
      date instanceof Date &&
      !isNaN(date) &&
      date.getFullYear() === y &&
      date.getMonth() === m - 1 &&
      date.getDate() === d
    );
  }
}

// Create a global instance for the application
let characterValidator;

// This function must be called after profanity.js is loaded
function initializeValidator() {
  if (typeof profList !== "undefined") {
    const re = "(" + profList.join("|") + ")\\b";
    const profanityRegex = new RegExp(re, "i");
    characterValidator = new CharacterValidator(profanityRegex);
  } else {
    console.error("Profanity list not found. Validation may not work correctly.");
    // Create with empty regex as fallback
    characterValidator = new CharacterValidator(/^$/);
  }
}
