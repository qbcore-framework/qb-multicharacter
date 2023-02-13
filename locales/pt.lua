local Translations = {
    notifications = {
        ["char_deleted"] = "Personagem apagado!",
        ["deleted_other_char"] = "Eliminaste com sucesso o personagem com o ID de cidadão %{citizenid}.",
        ["forgot_citizenid"] = "Esqueceu-se de inserir um ID de cidadão!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Apaga o personagem de outro jogador",
		["citizenid"] = "ID de cidadão",
		["citizenid_help"] = "O ID de cidadão do personagem que pretende apagar",

        - /logout
    ["logout_description"] = "Desconectar de personagem (Apenas administrador)",

    -- /closeNUI
    ["closeNUI_description"] = "Fechar Multi NUI"
    },

    misc = {
        ["droppedplayer"] = "Desconectou-se do Servidor"
    },

    ui = {
        -- Main
        characters_header = "Os Meus Personagens",
        emptyslot = "Slot Vazio",
        play_button = "Jogar",
        create_button = "Criar Personagem",
        delete_button = "Apagar Personagem",

        -- Character Information
        charinfo_header = "Informação do Personagem",
        charinfo_description = "Selecione um slot de personagem para ver todas as informações sobre o seu personagem.",
        name = "Nome",
        male = "Masculino",
        female = "Feminino",
        firstname = "Primeiro Nome",
        lastname = "Último Nome",
        nationality = "Nacionalidade",
        gender = "Género",
        birthdate = "Data de Nascimento",
        job = "Trabalho",
        jobgrade = "Cargo",
        cash = "Dinheiro",
        bank = "Banco",
        phonenumber = "Contacto",
        accountnumber = "Número de conta",

         chardel_header = "Registo do Personagem",

        -- Delete character
        deletechar_header = "Apagar Personagem",
		deletechar_description = "Tem a certeza de que pretende apagar o seu personagem?",

        -- Buttons
        cancel = "Cancelar",
        confirm = "Confirmar",

        -- Loading Text
        retrieving_playerdata = "A obter dados do jogador",
		validating_playerdata = "A validar dados do jogador",
		retrieving_characters = "A obter personagens",
		validating_characters = "A validar personagens"

        -- Notifications
        ran_into_issue = "Encontrámos um problema",
		profanity = "Parece que está a tentar usar algum tipo de palavrão/palavras más no seu nome ou na sua nacionalidade!",
		forgotten_field = "Parece que se esqueceu de inserir um ou vários dos campos!"
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
