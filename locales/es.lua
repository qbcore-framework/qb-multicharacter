Translations = {
    notifications = {
        ["char_deleted"] = "¡Personaje eliminado!",
        ["deleted_other_char"] = "Has eliminado con éxito el personaje con id de ciudadano %{citizenid}",
        ["forgot_citizenid"] = "¡Olvidaste introducir un id de ciudadano!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Borra el personaje de otro jugador",
        ["citizenid"] = "ID del ciudadano",
        ["citizenid_help"] = "El ID del ciudadano del jugador que quieres eliminar",

        -- /logout
        ["logout_description"] = "Cerrar sesión de personaje (solo administrador)",

        -- /closeNUI
        ["closeNUI_description"] = "Cerrar Multi NUI"
    },

    misc = {
        ["droppedplayer"] = "Te has desconectado de QBCore"
    },

    ui = {
        -- Main
        characters_header = "Mis personajes",
        emptyslot = "Espacio vacío",
        play_button = "Jugar",
        create_button = "Crear personaje",
        delete_button = "Eliminar personaje",

        -- Character Information
        charinfo_header = "Información del personaje",
        charinfo_description = "Selecciona un personaje para ver toda la información sobre el mismo",
        name = "Nombre",
        male = "Hombre",
        female = "Mujer",
        firstname = "Nombre",
        lastname = "Apellido",
        nationality = "Nacionalidad",
        gender = "Género",
        birthdate = "Fecha de nacimiento",
        job = "Trabajo",
        jobgrade = "Puesto de trabajo",
        cash= "Dinero",
        bank = "Banco",
        phonenumber = "Número de teléfono",
        accountnumber = "Número de cuenta",

        chardel_header = "Registro de personajes",

        -- Delete character
        deletechar_header = "Eliminar personaje",
        deletechar_description = "¿Estás seguro que quieres eliminar tu personaje?",

        -- Buttons
        cancel = "Cancelar",
        confirm = "Confirmar",

        -- Loading Text
        retrieving_playerdata = "Recuperando datos del jugador",
        validating_playerdata = "Validando los datos del jugador",
        retrieving_characters = "Recuperando personajes",
        validating_characters = "Validando personajes",

        -- Notifications
        ran_into_issue = "Tuvimos un problema",
        profanity = "¡Parece que estás intentando utilizar algún tipo de blasfemia / mala(s) palabra(s) en tu nombre o nacionalidad!",
        forgotten_field = "¡Parece que has olvidado introducir uno o varios campos!"
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
