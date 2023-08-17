local Translations = {
    notifications = {
        ["char_deleted"] = "Charakter gelöscht!",
        ["deleted_other_char"] = "Sie haben den Charakter erfolgreich mit der ID %{Citizenid} gelöscht.",
        ["forgot_citizenid"] = "Sie haben vergessen, eine ID einzugeben!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Löscht einen anderen Spielercharakter",
        ["citizenid"] = "ID",
        ["citizenid_help"] = "Die ID des Charakters, den Sie löschen möchten",

        -- /logout
        ["logout_description"] = "Ausloggen des Charakters (Nur Admins!)",

        -- /closeNUI
        ["closeNUI_description"] = "Multi Nui schließen"
    },

    misc = {
        ["droppedplayer"] = "Sie haben sich von Qbcore getrennt"
    },

    ui = {
        -- Main
        characters_header = "Meine Charaktere",
        emptyslot = "Verfügbare Slots",
        play_button = "Aufwachen",
        create_button = "Charakter erstellen",
        delete_button = "Charakter löschen",

        -- Character Information
        charinfo_header = "Charakterinformationen",
        charinfo_description = "Wählen Sie einen Charakter aus, um alle Informationen zu Ihrem Charakter anzuzeigen.",
        name = "Name",
        male = "Männlich",
        female = "Weiblich",
        firstname = "Vorname",
        lastname = "Familienname, Nachname",
        nationality = "Staatsangehörigkeit",
        gender = "Geschlecht",
        birthdate = "Geburtsdatum",
        job = "Beruf",
        jobgrade = "Dienstgrad",
        cash = "Bargeld",
        bank = "Bankkonto",
        phonenumber = "Telefonnummer",
        accountnumber = "Accountnummer",

        chardel_header = "Charakterregistrierung",

        -- Delete character
        deletechar_header = "Charakter löschen",
        deletechar_description = "Sind Sie sich sicher, dass Sie Ihren Charakter löschen möchten?",

        -- Buttons
        cancel = "Abbrechen",
        confirm = "Bestätigen",

        -- Loading Text
        retrieving_playerdata = "Spielerdaten abrufen",
        validating_playerdata = "Spielerdaten validieren",
        retrieving_characters = "Charaktere abrufen",
        validating_characters = "Charaktere validieren",

        -- Notifications
        ran_into_issue = "Wir sind auf ein Problem gestoßen",
        profanity = "Es scheint, als ob Sie versuchen, in Ihrem Namen oder in Ihrer Nationalität eine Art von Obszönität / schlechte Worte verwenden!",
        forgotten_field = "Es scheint, als hätten Sie vergessen, ein oder mehrere der Felder einzugeben!"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
