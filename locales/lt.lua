Translations = {
    notifications = {
        ["char_deleted"] = "Personažas ištrintas!",
        ["deleted_other_char"] = "Jūs sėkmingai ištrinėte personažą su asmens kodu - %{citizenid}.",
        ["forgot_citizenid"] = "Jūs pamiršote įvesti asmens kodą!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Ištrina kito žaidėjo personažą",
        ["citizenid"] = "Asmens kodas",
        ["citizenid_help"] = "Personažo, kuri norite ištrinti, asmens kodas ",

        -- /logout
        ["logout_description"] = "Atsijungti nuo personažo (Tik administratoriams)",

        -- /closeNUI
        ["closeNUI_description"] = "Uždaryti Multi NUI"
    },

    misc = {
        ["droppedplayer"] = "Jūs buvote atjungtas iš QBCore"
    },

    ui = {
        -- Main
        characters_header = "Mano personažai",
        emptyslot = "Laisva vieta",
        play_button = "Žaisti",
        create_button = "Sukurti personažą",
        delete_button = "Ištrinti personažą",

        -- Character Information
        charinfo_header = "Personažo informacija",
        charinfo_description = "Pasirinkite personažą, norint matyti visą informaciją apie jį.",
        name = "Vardas",
        male = "Vyras",
        female = "Moteris",
        firstname = "Vardas",
        lastname = "Pavardė",
        nationality = "Tautybė",
        gender = "Lytis",
        birthdate = "Gimimo diena",
        job = "Darbas",
        jobgrade = "Laipsnis",
        cash = "Grynieji pinigai",
        bank = "Pinigai banke",
        phonenumber = "Telefono numeris",
        accountnumber = "Sąskaitos numeris",

        chardel_header = "Personažo registracija",

        -- Delete character
        deletechar_header = "Ištrinti personažą",
        deletechar_description = "Ar jūs esate įsitikinęs, kad norite ištrinti savo personažą?",

        -- Buttons
        cancel = "Atšaukti",
        confirm = "Patvirtinti",

        -- Loading Text
        retrieving_playerdata = "Gaunami žaidėjo duomenys",
        validating_playerdata = "Patvirtinami žaidėjo duomenys",
        retrieving_characters = "Gaunami personažai",
        validating_characters = "Patvirtinami personažai",

        -- Notifications
        ran_into_issue = "Mes susidūrėme su problemomis",
        profanity = "Atrodo, jog bandote naudoti keiksmažodžius / blogus žodžius savo varde ar tautybėje!",
        forgotten_field = "Atrodo, kad pamiršote įvesti vieną ar daugiau laukelių!"
    }
}

if GetConvar('qb_locale', 'en') == 'lt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
