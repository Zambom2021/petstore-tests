class categories:
    """Library que gerencia categorias de pets (Dogs, Cats, Birds)."""

    def __init__(self):
        self.categories = {
            "Dogs": {"id": 1, "name": "Dogs"},
            "Cats": {"id": 2, "name": "Cats"},
            "Birds": {"id": 3, "name": "Birds"}
        }

    def get_category(self, name):
        """Keyword: Retorna uma categoria pelo nome."""
        return self.categories.get(name, None)

    def get_all_categories(self):
        """Keyword: Retorna todas as categorias."""
        return list(self.categories.values())
