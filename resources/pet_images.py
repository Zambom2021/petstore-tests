import os
import random

class pet_images:
    """Classe utilitária para selecionar imagens conforme a categoria do Pet."""

    def __init__(self):
        base_dir = os.path.dirname(os.path.abspath(__file__))
        self.images_path = os.path.join(base_dir, "../resources/images")

        # Dicionário de categorias e imagens disponíveis
        self.images = {
            "Dogs": ["dog1.jpg", "dog2.jpg", "dog3.jpg"],
            "Cats": ["cat1.jpg", "cat2.jpg", "cat3.jpg"],
            "Birds": ["bird1.jpg", "bird2.jpg"],
            "Reptiles": ["reptile1.jpg"],
        }

    def get_image_by_category(self, category: str) -> str:
        """Retorna o caminho completo de uma imagem aleatória pela categoria."""
        category = category.capitalize()
        if category not in self.images:
            raise ValueError(f"Categoria '{category}' não encontrada.")

        # Seleciona uma imagem aleatória da categoria
        image_name = random.choice(self.images[category])
        image_path = os.path.abspath(os.path.join(self.images_path, image_name))

        if not os.path.exists(image_path):
            raise FileNotFoundError(f"Imagem não encontrada: {image_path}")

        return image_path
