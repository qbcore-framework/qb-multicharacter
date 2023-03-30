local Translations = {
    notifications = {
        ["char_deleted"] = "Personagem deletado!",
        ["deleted_other_char"] = "Você deletou o personagem do id %{citizenid} com sucesso.",
        ["forgot_citizenid"] = "Você esqueceu de colocaro id do personagem!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Deleta o personagem de outra pessoa",
        ["citizenid"] = "ID Cidadão",
        ["citizenid_help"] = "O ID do Cidadão que você quer deletar",

        -- /logout
        ["logout_description"] = "Deslogar do personagem (Apenas administradores)",

        -- /closeNUI
        ["closeNUI_description"] = "Fechar multi UI"
    },

    misc = {
        ["droppedplayer"] = "Você desconectou do QBCore"
    },

    ui = {
        -- Main
        characters_header = "Meus personagens",
        emptyslot = "Espaço vazio",
        play_button = "Play",
        create_button = "Criar personagem",
        delete_button = "Deletar personagem",

        -- Character Information
        charinfo_header = "Informação do personagem",
        charinfo_description = "Selecione um personagem para ver as informações dele.",
        name = "Nome",
        male = "Masculino",
        female = "Feminino",
        firstname = "Primeiro nome",
        lastname = "Sobrenome",
        nationality = "Nacionalidade",
        gender = "Genêro",
        birthdate = "Data de aniversário",
        job = "Trabalho",
        jobgrade = "Nivel do trabalho",
        cash = "Dinheiro",
        bank = "Banco",
        phonenumber = "Número do celular",
        accountnumber = "Número da conta",

        chardel_header = "Registro do personagem",

        -- Delete character
        deletechar_header = "Deletar personagem",
        deletechar_description = "Você tem certeza que quer deletar o personagem?",

        -- Buttons
        cancel = "Cancelar",
        confirm = "Confrimar",

        -- Loading Text
        retrieving_playerdata = "Recebendo dados do player",
        validating_playerdata = "Validando dados do player",
        retrieving_characters = "Recebendo dados do personagem",
        validating_characters = "Valiodando personagem",

        -- Notifications
        ran_into_issue = "Um problema foi encontrado, por favor reporte",
        profanity = "Pelo que parece você está tentando usar palavras proibidas/de baixo calão no seu nome/nacionalidade. Por favor reveja os dados inseridos!",
        forgotten_field = "Pelo que parece você esqueceu de preencher um ou mais campos!"
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

