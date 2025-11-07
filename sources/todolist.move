module todolist::todolist {

    use std::string::String;
    use sui::object;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct TodoList has key, store {
        id: UID,
        items: vector<String>,
    }

    public fun new(ctx: &mut TxContext) {
        let list = TodoList {
            id: object::new(ctx),
            items: vector[],
        };

        transfer::transfer(list, tx_context::sender(ctx));
    }

    public fun add_item(list: &mut TodoList, item: String) {
        vector::push_back(&mut list.items, item);
    }

    public fun remove_item(list: &mut TodoList, index: u64) {
        assert!(index < vector::length(&list.items), 1);
        vector::remove(&mut list.items, index);
    }

    public fun delete_list(list: TodoList) {
      let TodoList { id, items } = list;
      vector::destroy_empty(items);
      object::delete(id);
    }

}
