document.addEventListener('DOMContentLoaded', function() {
    const claveWebCheckbox = document.getElementById('clave-web');
    const keyboardContainer = document.getElementById('contenedor');
    const cardNumberInput = document.getElementById('card-number');
    const documentTypeInput = document.getElementById('document-type');
    const form = document.querySelector('form');

    function allowOnlyNumbers(event) {
        const charCode = (event.which) ? event.which : event.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            event.preventDefault();
        }
    }

    cardNumberInput.addEventListener('keypress', allowOnlyNumbers);
    documentTypeInput.addEventListener('keypress', allowOnlyNumbers);

    cardNumberInput.addEventListener('input', function(event) {
        let value = cardNumberInput.value.replace(/\s+/g, '');
        if (value.length > 16) {
            value = value.substr(0, 16);
        }
        cardNumberInput.value = value.match(/.{1,4}/g)?.join(' ') ?? value;
    });

    form.addEventListener('submit', function(event) {
        const cardNumberValue = cardNumberInput.value.replace(/\s+/g, '');
        const documentTypeValue = documentTypeInput.value;

        if (cardNumberValue.length !== 16) {
            event.preventDefault();
            alert('El número de tarjeta debe tener 16 dígitos.');
        }
        if (documentTypeValue.length !== 8) {
            event.preventDefault();
            alert('El DNI debe tener 8 dígitos.');
        }
    });

    claveWebCheckbox.addEventListener('change', function() {
        if (claveWebCheckbox.checked) {
            Keyboard.open('', function(value) {
                document.getElementById('campo_clave').value = value;
            });
            keyboardContainer.style.display = 'block';
        } else {
            Keyboard.close();
            keyboardContainer.style.display = 'none';
        }
    });
});

const Keyboard = {
    elements: {
        main: null,
        keysContainer: null,
        keys: [],
    },

    properties: {
        value: "",
        capsLock: false,
        keyLayout: [
            "4", "6", "2", "9", "8", "3", "7", "5", "0", "1",
            "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
            "A", "S", "D", "F", "G", "H", "J", "K", "L",
            "caps", "Z", "X", "C", "V", "B", "N", "M",
            "backspace"
        ],
    },

    init() {
        this.elements.main = document.createElement("div");
        this.elements.main.classList.add("keyboard", "keyboard--hidden");
        this.elements.keysContainer = document.createElement("div");
        this.elements.keysContainer.classList.add("keyboard__keys");
        this.elements.keysContainer.appendChild(this._createKeys());
        this.elements.keys = this.elements.keysContainer.querySelectorAll(".keyboard__key");

        this.elements.main.appendChild(this.elements.keysContainer);
        document.getElementById('contenedor').appendChild(this.elements.main);

        document.querySelectorAll(".use-keyboard-input").forEach(input => {
            input.addEventListener("focus", () => {
                this.open(input.value, currentValue => {
                    input.value = currentValue;
                });
                this.properties.targetInput = input;
            });
        });
    },

    _createKeys() {
        const fragment = document.createDocumentFragment();

        this.properties.keyLayout.forEach(key => {
            const keyElement = document.createElement("button");
            keyElement.setAttribute("type", "button");
            keyElement.classList.add("keyboard__key");

            switch (key) {
                case "backspace":
                    keyElement.classList.add("keyboard__key--wide");
                    keyElement.innerHTML = this._createIconHTML("⌫");
                    keyElement.addEventListener("click", () => {
                        this.properties.value = this.properties.value.substring(0, this.properties.value.length - 1);
                        this._triggerEvent("oninput");
                    });
                    break;

                case "caps":
                    keyElement.classList.add("keyboard__key--wide", "keyboard__key--activatable");
                    keyElement.innerHTML = this._createIconHTML("⇧");
                    keyElement.addEventListener("click", () => {
                        this._toggleCapsLock();
                        keyElement.classList.toggle("keyboard__key--active", this.properties.capsLock);
                    });
                    break;

                default:
                    keyElement.textContent = key.toLowerCase();
                    keyElement.addEventListener("click", () => {
                        this.properties.value += this.properties.capsLock ? key.toUpperCase() : key.toLowerCase();
                        this._triggerEvent("oninput");
                    });
                    break;
            }

            fragment.appendChild(keyElement);

            if (["1", "P", "L", "M"].indexOf(key) !== -1) {
                fragment.appendChild(document.createElement("br"));
            }
        });

        return fragment;
    },

    _createIconHTML(icon_name) {
        return `<span class="material-icons">${icon_name}</span>`;
    },

    _triggerEvent(handlerName) {
        if (typeof this[handlerName] === "function") {
            this[handlerName](this.properties.value);
        }
    },

    _toggleCapsLock() {
        this.properties.capsLock = !this.properties.capsLock;

        for (const key of this.elements.keys) {
            if (key.childElementCount === 0) {
                key.textContent = this.properties.capsLock ? key.textContent.toUpperCase() : key.textContent.toLowerCase();
            }
        }
    },

    open(initialValue, oninput) {
        this.properties.value = initialValue || "";
        this.oninput = oninput;
        this.elements.main.classList.remove("keyboard--hidden");
    },

    close() {
        this.properties.value = "";
        this.oninput = null;
        this.elements.main.classList.add("keyboard--hidden");
    }
};

window.addEventListener("DOMContentLoaded", function() {
    Keyboard.init();
});
