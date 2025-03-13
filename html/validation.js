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
            ],
        };
    }

    /**
     * Validate a complete character form
     * @param {Object} character - Character data object
     * @returns {Object} Result with isValid flag and any error message
     */
    validateCharacter(character) {
        // Check each field
        for (const field in this.validators) {
            if (this.validators.hasOwnProperty(field)) {
                const result = this.validateField(field, character[field]);
                if (!result.isValid) {
                    return result;
                }
            }
        }

        // Additional cross-field validations could go here

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

        if (!fieldValidators) {
            return { isValid: true };
        }

        for (const validator of fieldValidators) {
            if (!validator.test(value)) {
                return {
                    isValid: false,
                    field: fieldName,
                    message: validator.message,
                };
            }
        }

        return { isValid: true };
    }

    /**
     * Check if a date string is valid
     * @param {string} dateString - Date in YYYY-MM-DD format
     * @returns {boolean} True if valid
     */
    isValidDate(dateString) {
        // Basic format check
        if (!/^\d{4}-\d{2}-\d{2}$/.test(dateString)) {
            return false;
        }

        // Parse the date
        const parts = dateString.split("-");
        const year = parseInt(parts[0], 10);
        const month = parseInt(parts[1], 10) - 1; // Months are 0-based
        const day = parseInt(parts[2], 10);

        // Create date and check if valid
        const date = new Date(year, month, day);
        if (date.getFullYear() !== year || date.getMonth() !== month || date.getDate() !== day) {
            return false;
        }

        // Check reasonable range
        const currentYear = new Date().getFullYear();
        if (year < 1900 || year > currentYear) {
            return false;
        }

        return true;
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
