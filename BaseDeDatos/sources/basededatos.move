module basededatos::basededatos {
    use std::string::{String, utf8};
    use sui::vec_map::{VecMap, Self};

    public struct Base has key, store {
        id: UID,
        nombre: String, 
        datos: VecMap<u8, Usuario>
    }

    public struct Usuario has store, drop {
        nombre_usuario: String, 
        edad: u8, 
        informacion: vector<String>
    }

    public enum Mascota has store, drop {
        perro(Perro),
        gato(Gato),
    }

    public struct Perro has store, drop {
        nombre: String,
        edad: u8, 
    }

    public struct Gato has store, drop {
        nombre: String,
        edad: u8, 
    }

    #[error]
    const ID_REPETIDO: vector<u8> = b"ERROR: EL ID YA EXISTE, INTENTA CON OTRO";

    public fun crear_base_de_datos(ctx: &mut TxContext, nombre: String) {

        let base_de_datos = Base {
            id:object::new(ctx),
            nombre, 
            datos: vec_map::empty()
        };

        transfer::transfer(base_de_datos, tx_context::sender(ctx));

    }

    public fun agregar_usuario(base_de_datos: &mut Base, nombre: String, edad: u8, id: u8) {
        assert!(!base_de_datos.datos.contains(&id), ID_REPETIDO);

        let usuario = Usuario {
            nombre_usuario: nombre, 
            edad, 
            informacion: vector[]
        };

        base_de_datos.datos.insert(id, usuario);
    }

}