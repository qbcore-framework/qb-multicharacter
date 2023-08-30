local Translations = {
    notifications = {
        ["char_deleted"] = "Personagem deletado!",
        ["deleted_other_char"] = "Você deletou com sucesso o personagem com o ID de cidadão %{citizenid}.",
        ["forgot_citizenid"] = "Você esqueceu de inserir um ID de cidadão!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Exclui o personagem de outro jogador",
        ["citizenid"] = "ID de Cidadão",
        ["citizenid_help"] = "O ID de Cidadão do personagem que você deseja excluir",

        -- /logout
        ["logout_description"] = "Sair do Personagem (Apenas para Administradores)",

        -- /closeNUI
        ["closeNUI_description"] = "Fechar Multi NUI"
    },

    misc = {
        ["droppedplayer"] = "Você desconectou do QBCore"
    },

    ui = {
        -- Principal
        characters_header = "Meus Personagens",
        emptyslot = "Vaga Vazia",
        play_button = "Jogar",
        create_button = "Criar Personagem",
        delete_button = "Excluir Personagem",

        -- Informações do Personagem
        charinfo_header = "Informações do Personagem",
        charinfo_description = "Selecione uma vaga de personagem para ver todas as informações sobre o seu personagem.",
        name = "Nome",
        male = "Masculino",
        female = "Feminino",
        firstname = "Primeiro Nome",
        lastname = "Sobrenome",
        nationality = "Nacionalidade",
        gender = "Gênero",
        birthdate = "Data de Nascimento",
        job = "Profissão",
        jobgrade = "Nível Profissional",
        cash = "Dinheiro",
        bank = "Banco",
        phonenumber = "Número de Telefone",
        accountnumber = "Número da Conta",

        chardel_header = "Registro de Personagem",

        -- Excluir personagem
        deletechar_header = "Excluir Personagem",
        deletechar_description = "Você tem certeza de que deseja excluir o seu personagem?",

        -- Botões
        cancel = "Cancelar",
        confirm = "Confirmar",

        -- Texto de Carregamento
        retrieving_playerdata = "Recuperando dados do jogador",
        validating_playerdata = "Validando dados do jogador",
        retrieving_characters = "Recuperando personagens",
        validating_characters = "Validando personagens",

        -- Notificações
        ran_into_issue = "Encontramos um problema",
        profanity = "Parece que você está tentando usar algum tipo de palavrão ou linguagem imprópria em seu nome ou nacionalidade!",
        forgotten_field = "Parece que você esqueceu de preencher um ou vários campos!"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
