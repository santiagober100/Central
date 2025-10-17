module biblioteca::biblioteca{
    use std::string::String;
    use sui::vec_map;
    use sui::vec_map::VecMap;
    const Placa_existente: u64=1;
    public struct Biblioteca has key, store{
        id: UID, 
        libros:VecMap<u64, Libro>,
    }
    public struct Libro has copy, drop, store{
        titulo:String,
        ubicacion:String, 
    }
    public fun crear_biblioteca(ctx:&mut TxContext){
        let libros=vec_map::empty<u64, Libro>();
        let biblioteca=Biblioteca{
            id:object::new(ctx),
            libros,
        };
        transfer::transfer(biblioteca, tx_context::sender(ctx));
    }
    public fun agregar_libro(biblioteca: &mut Biblioteca, placa: u64, titulo:String, ubicacion:String){
        assert!(!biblioteca.libros.contains(&placa), Placa_existente);
        let nuevo_libro=Libro{titulo, ubicacion};
        biblioteca.libros.insert(placa, nuevo_libro);
    }
}