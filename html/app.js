let re = "(" + profList.join("|") + ")\\b";
const regTest = new RegExp(re, "i");

document.addEventListener("DOMContentLoaded", () => {
    const viewmodel = new Vue({
        el: "#app",
        vuetify: new Vuetify({ theme: { dark: true } }),
        data: {
            characters: [],
            chardata: {},
            show: {
                loading: false,
                characters: false,
                register: false,
                delete: false,
            },
            registerData: {
                date: new Date(Date.now() - new Date().getTimezoneOffset() * 60000).toISOString().substr(0, 10),
                firstname: undefined,
                lastname: undefined,
                nationality: undefined,
                gender: undefined,
            },
            allowDelete: false,
            dataPickerMenu: false,
            characterAmount: 0,
            loadingText: "",
            selectedCharacter: -1,
            dollar: Intl.NumberFormat("en-US"),
            translations: {},
            customNationality: false,
            nationalities: [],
        },
        methods: {
            click_character: function (idx, type) {
                this.selectedCharacter = idx;

                if (this.characters[idx] !== undefined) {
                    axios.post("https://qb-multicharacter/cDataPed", {
                        cData: this.characters[idx],
                    });
                } else {
                    axios.post("https://qb-multicharacter/cDataPed", {});
                    // For empty slots, immediately show the registration form
                    if (type === "empty") {
                        this.resetRegisterData();
                        this.show.characters = false;
                        this.show.register = true;
                    }
                }
            },
            prepareDelete: function () {
                this.show.characters = false;
                this.show.delete = true;
            },
            cancelDelete: function () {
                this.show.delete = false;
                this.show.characters = true;
            },
            cancelCreate: function () {
                this.show.register = false;
                this.show.characters = true;
            },
            delete_character: function () {
                if (this.show.delete) {
                    this.show.delete = false;
                    axios.post("https://qb-multicharacter/removeCharacter", {
                        citizenid: this.characters[this.selectedCharacter].citizenid,
                    });
                    setTimeout(() => {
                        this.show.characters = true;
                    }, 500);
                }
            },
            play_character: function () {
                if (this.selectedCharacter !== -1) {
                    var data = this.characters[this.selectedCharacter];

                    if (data !== undefined) {
                        axios.post("https://qb-multicharacter/selectCharacter", {
                            cData: data,
                        });
                        setTimeout(() => {
                            this.show.characters = false;
                        }, 500);
                    } else {
                        this.resetRegisterData();
                        this.show.characters = false;
                        this.show.register = true;
                    }
                }
            },
            resetRegisterData: function () {
                this.show.characters = false;
                this.show.register = true;
                this.registerData = {
                    date: new Date(Date.now() - new Date().getTimezoneOffset() * 60000).toISOString().substr(0, 10),
                    firstname: undefined,
                    lastname: undefined,
                    nationality: undefined,
                    gender: undefined,
                };
            },
            create_character: function () {
                const registerData = this.registerData;
                const validationResult = characterValidator.validateCharacter({
                    firstname: registerData.firstname,
                    lastname: registerData.lastname,
                    nationality: registerData.nationality,
                    gender: registerData.gender,
                    date: registerData.date,
                });

                if (validationResult.isValid) {
                    this.show.register = false;

                    axios.post("https://qb-multicharacter/createNewCharacter", {
                        firstname: registerData.firstname,
                        lastname: registerData.lastname,
                        nationality: registerData.nationality,
                        birthdate: registerData.date,
                        gender: registerData.gender,
                        cid: this.selectedCharacter,
                    });

                    setTimeout(() => {
                        this.show.characters = false;
                    }, 500);
                } else {
                    Swal.fire({
                        icon: "error",
                        title: this.translate("ran_into_issue"),
                        text: this.translate(validationResult.message, { field: this.translate(validationResult.field) }),
                        timer: 5000,
                        timerProgressBar: true,
                        showConfirmButton: false,
                    });
                }
            },
            translate(key, params) {
                if (params) {
                    return translationManager.formatTranslation(key, params);
                }
                return translationManager.translate(key);
            },
        },
        mounted() {
            initializeValidator();
            var loadingProgress = 0;
            var loadingDots = 0;
            window.addEventListener("message", (event) => {
                var data = event.data;
                switch (data.action) {
                    case "ui":
                        this.customNationality = event.data.customNationality;
                        translationManager.setTranslations(event.data.translations);
                        this.translations = event.data.translations;
                        this.nationalities = event.data.countries;
                        this.characterAmount = data.nChar;
                        this.selectedCharacter = -1;
                        this.show.register = false;
                        this.show.delete = false;
                        this.show.characters = false;
                        this.allowDelete = event.data.enableDeleteButton;
                        EnableDeleteButton = data.enableDeleteButton;

                        if (data.toggle) {
                            this.show.loading = true;
                            this.loadingText = this.translate("retrieving_playerdata");
                            var DotsInterval = setInterval(() => {
                                loadingDots++;
                                loadingProgress++;
                                if (loadingProgress == 3) {
                                    this.loadingText = this.translate("validating_playerdata");
                                }
                                if (loadingProgress == 4) {
                                    this.loadingText = this.translate("retrieving_characters");
                                }
                                if (loadingProgress == 6) {
                                    this.loadingText = this.translate("validating_characters");
                                }
                                if (loadingDots == 4) {
                                    loadingDots = 0;
                                }
                            }, 500);

                            setTimeout(() => {
                                axios.post("https://qb-multicharacter/setupCharacters");
                                setTimeout(() => {
                                    clearInterval(DotsInterval);
                                    loadingProgress = 0;
                                    this.loadingText = this.translate("retrieving_playerdata");
                                    this.show.loading = false;
                                    this.show.characters = true;
                                    axios.post("https://qb-multicharacter/removeBlur");
                                }, 2000);
                            }, 2000);
                        }
                        break;
                    case "setupCharacters":
                        var newChars = [];
                        for (var i = 0; i < event.data.characters.length; i++) {
                            newChars[event.data.characters[i].cid] = event.data.characters[i];
                        }
                        this.characters = newChars;
                        break;
                    case "setupCharInfo":
                        this.chardata = event.data.chardata;
                        break;
                }
            });
        },
    });
});
