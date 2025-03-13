/**
 * Translations utility for QB-Multicharacter
 * Handles all translation functionality in one place
 */

class TranslationManager {
    constructor() {
        this.translations = {};
        this.fallbacks = {
            // Default English fallbacks for common keys
            deletechar_description: "Are you sure you want to delete this character?",
            confirm: "Confirm",
            cancel: "Cancel",
            chardel_header: "Character Registration",
            firstname: "First Name",
            lastname: "Last Name",
            nationality: "Nationality",
            birthdate: "Date of Birth",
            gender: "Gender",
            male: "Male",
            female: "Female",
            create_button: "Create Character",
            retrieving_playerdata: "Retrieving player data...",
            validating_playerdata: "Validating player data...",
            retrieving_characters: "Retrieving characters...",
            validating_characters: "Validating characters...",
            ran_into_issue: "We ran into an issue!",
            profanity: "Your inputs contain profanity. Please try again.",
            forgotten_field: "You forgot to fill in a field!",
            connection_error: "Connection error. Please try again.",
            delete_failed: "Failed to delete character. Please try again.",
            selection_failed: "Failed to select character. Please try again.",
            creation_failed: "Failed to create character. Please try again.",
            setup_failed: "Failed to set up characters. Please try again.",

            // New validation-specific keys
            firstname_too_short: "First name must be at least 2 characters long.",
            firstname_too_long: "First name cannot exceed 16 characters.",
            lastname_too_short: "Last name must be at least 2 characters long.",
            lastname_too_long: "Last name cannot exceed 16 characters.",
            invalid_date: "Please enter a valid date of birth.",
            date: "Date of Birth",
            field: "Field",
        };
    }

    /**
     * Set translations from server
     * @param {Object} translations - Translation key-value pairs
     */
    setTranslations(translations) {
        this.translations = translations || {};
    }

    /**
     * Get translation for a key
     * @param {string} key - Translation key
     * @returns {string} Translated text or fallback
     */
    translate(key) {
        // First check in server-provided translations
        if (this.translations[key]) {
            return this.translations[key];
        }

        // Then check in fallbacks
        if (this.fallbacks[key]) {
            return this.fallbacks[key];
        }

        // Return the key itself if no translation found
        return key;
    }

    /**
     * Format a translation with dynamic values
     * @param {string} key - Translation key
     * @param {Object} params - Object containing replacement values
     * @returns {string} Formatted translation
     */
    formatTranslation(key, params) {
        let text = this.translate(key);

        if (params) {
            Object.keys(params).forEach((param) => {
                text = text.replace(`{${param}}`, params[param]);
            });
        }

        return text;
    }
}

// Create a global instance for the application
const translationManager = new TranslationManager();
