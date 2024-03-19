local Translations = {
    notifications = {
        ["char_deleted"] = "!דמות נמחקה",
        ["deleted_other_char"] = " אתה בהצלחה מחקתה דמות עם מזהה %{citizenid}.", -- אתה בהצלחה מחקתה דמות עם מזהה %{citizenid}
        ["forgot_citizenid"] = "!שכחת לכלול מזהה", -- 
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "מוחק דמויות של שחקנים אחרים",
        ["citizenid"] = "מזהה", 
        ["citizenid_help"] = "המזהה של הדמות שאתה רוצה למחוק", 
        -- /logout
        ["logout_description"] = "להתנתק מדמות (אדמין בלבד)", 

        -- /closeNUI
        ["closeNUI_description"] = "סגור Multi NUI"
    },

    misc = {
        ["droppedplayer"] = "התנתקת מQBCore"
    },

    ui = {
        -- Main
        characters_header = "הדמויות שלי",
        emptyslot = "דמות ריקה",
        play_button = "שחק",
        create_button = "צור דמות",
        delete_button = "מחק דמות",

        -- Character Information
        charinfo_header = "מידע על דמות",
        charinfo_description = " בחר דמות שאתה רוצה לראות את כל המידע עליה.", 
        name = "שם",
        male = "גבר",
        female = "אישה",
        firstname = "שם פרטי",
        lastname = "שם משפחה",
        nationality = "אזרחות",
        gender = "מגדר",
        birthdate = "תאריך לידה",
        job = "עבודה",
        jobgrade = "תפקיד",
        cash = "מזומן",
        bank = "בנק",
        phonenumber = "מספר טלפון",
        accountnumber = "מספר משתמש",

        chardel_header = "רישום דמות",

        -- Delete character
        deletechar_header = "מחיקת דמות",
        deletechar_description = "?אתה בטוח שאתה רוצה למחוק את הדמות שלך",

        -- Buttons
        cancel = "בטל",
        confirm = "אישור",

        -- Loading Text
        retrieving_playerdata = "משיג נתוני שחקן",
        validating_playerdata = "מאמת נתוני שחקן",
        retrieving_characters = "משיג דמויות",
        validating_characters = "מאמת דמויות",

        -- Notifications
        ran_into_issue = "נתקלנו בבעיה",
        profanity = "זה נראה שאתה מנסה להשתמש בסוג של שפה גסה / מילים רעות בשמך או בלאומיות שלך",
        forgotten_field = "!נראה ששכחת להזין אחד או יותר מהשדות"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
