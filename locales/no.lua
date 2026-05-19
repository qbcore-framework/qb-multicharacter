local Translations = {
    notifications = {
        ["char_deleted"] = "Karakter slettet!",
        ["deleted_other_char"] = "Du har slettet karakteren med Citizen ID %{citizenid}.",
        ["forgot_citizenid"] = "Du glemte å skrive inn Citizen ID!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Sletter en annen spillers karakter",
        ["citizenid"] = "Citizen ID",
        ["citizenid_help"] = "Citizen ID-en til karakteren du ønsker å slette",

        -- /logout
        ["logout_description"] = "Logg ut av karakter (Kun admin)",

        -- /closeNUI
        ["closeNUI_description"] = "Lukk Multi NUI"
    },

    misc = {
        ["droppedplayer"] = "Du har koblet fra QBCore"
    },

    ui = {
        -- Main
        characters_header = "Mine karakterer",
        emptyslot = "Tom plass",
        play_button = "Spill",
        create_button = "Opprett karakter",
        delete_button = "Slett karakter",

        -- Character Information
        charinfo_header = "Karakterinformasjon",
        charinfo_description = "Velg en karakterplass for å se all informasjon om karakteren din.",
        name = "Navn",
        male = "Mann",
        female = "Kvinne",
        firstname = "Fornavn",
        lastname = "Etternavn",
        nationality = "Nasjonalitet",
        gender = "Kjønn",
        birthdate = "Fødselsdato",
        job = "Jobb",
        jobgrade = "Jobbgrad",
        cash = "Kontanter",
        bank = "Bank",
        phonenumber = "Telefonnummer",
        accountnumber = "Kontonummer",

        chardel_header = "Karakterregistrering",

        -- Delete character
        deletechar_header = "Slett karakter",
        deletechar_description = "Er du sikker på at du vil slette karakteren din?",

        -- Buttons
        cancel = "Avbryt",
        confirm = "Bekreft",

        -- Loading Text
        retrieving_playerdata = "Henter spillerdata",
        validating_playerdata = "Validerer spillerdata",
        retrieving_characters = "Henter karakterer",
        validating_characters = "Validerer karakterer",

        -- Notifications
        ran_into_issue = "Vi støtte på et problem",
        profanity = "Det ser ut som du prøver å bruke støtende ord i navnet eller nasjonaliteten!",
        forgotten_field = "Det ser ut som du har glemt å fylle inn ett eller flere felt!"
    }
}

if GetConvar('qb_locale', 'en') == 'no' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
