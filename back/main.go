package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

// Product представляет продукт
type Product struct {
	ID          int
	ImageURL    string
	Name        string
	Description string
	Price       float64
	Features    string
	IsFavourite bool
	IsInCart    bool
	Quantity    int
}

/*
type CartItem struct {
	ProductID int
	Quantity  int
	//Options   map[string]string // Для хранения дополнительных опций продукта
}

type Cart struct {
	//UserID  int
	Items []CartItem
}

type Favourites struct {
	ProductID int
}*/

type User struct {
	ID    int
	Image string
	Name  string
	Phone string
	Mail  string
}

// Список продуктов
var products = []Product{
	{ID:          0,ImageURL:    "https://www.ixbt.com/img/n1/news/2024/3/2/cattouchretcr_large.jpg",Name:"Машина 1",Description:"Машина подходит для семейных поездок",Features:"Очень вместительная машина для всей семьи",Price:100000,IsFavourite: false,IsInCart:    false,Quantity:    0,},
	{ID:          1,ImageURL:    "https://www.ixbt.com/img/n1/news/2024/3/2/cattouchretcr_large.jpg",Name:"Машина 2",Description:"Машина подходит для поездок на дачу",Features:"Большой багажник имеется",Price:200000,IsFavourite: false,IsInCart:    false,Quantity:    0,},
	{ID:          2,ImageURL:    "https://www.ixbt.com/img/n1/news/2024/3/2/cattouchretcr_large.jpg",Name:"Гиперкар",Description:"Данный автомобиль предназначен для кольцевых гонок",Features:"Спортивные шины Мишлен",Price:100,IsFavourite: false,IsInCart:    false,Quantity:    0,},
	{ID:          3,ImageURL:    "https://www.ixbt.com/img/n1/news/2024/3/2/cattouchretcr_large.jpg",Name:"Машина Вина Дизеля",Description:"Автомобиль участвовал в съёмка Форсаж Токийский Дрифт",Features:"Достаточно смешная машина, подойдёт для одиноких граждан",Price:500000,IsFavourite: false,IsInCart:    false,Quantity:    0,},
	{ID:          4,ImageURL:    "https://www.ixbt.com/img/n1/news/2024/3/2/cattouchretcr_large.jpg",Name:"Машина Вина Дизеля",Description:"Автомобиль участвовал в съёмка Форсаж Токийский Дрифт",Features:"Достаточно смешная машина, подойдёт для одиноких граждан",Price:500000,IsFavourite: false,IsInCart:    false,Quantity:    0,},
	
}

var users = []User{{ID:    1, Image: "https://vkplay.ru/pre_0x736_resize/hotbox/content_files/Stories/2023/02/22/387a233b3d4349b68e2e4a235f38d2d0.jpg?quality=85", Name:  "Александр Быков", Mail:  "mail@email.com", Phone: "88005553535",}}

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)
	var lastID int = len(products)

	for _, productItem := range products {
		if productItem.ID > lastID {
			lastID = productItem.ID
		}
	}
	newProduct.ID = lastID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

//Добавление маршрута для получения одного продукта

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {
			products[i].Name = updatedProduct.Name
			products[i].ImageURL = updatedProduct.ImageURL
			products[i].Price = updatedProduct.Price
			products[i].Features = updatedProduct.Features
			products[i].Description = updatedProduct.Description
			products[i].IsFavourite = updatedProduct.IsFavourite
			products[i].IsInCart = updatedProduct.IsInCart
			products[i].Quantity = updatedProduct.Quantity

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func getCartHandler(w http.ResponseWriter, r *http.Request) {

	if r.Method != http.MethodGet {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	var cartProducts = []Product{}

	for _, Product := range products {
		if Product.IsInCart == true {
			w.Header().Set("Content-Type", "application/json")
			cartProducts = append(cartProducts, Product)
		}
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(cartProducts)
}
func getFavoritesHandler(w http.ResponseWriter, r *http.Request) {

	// Преобразуем список заметок в JSON
	var favoriteProducts = []Product{}

	for _, Product := range products {
		if Product.IsFavourite == true {
			w.Header().Set("Content-Type", "application/json")
			favoriteProducts = append(favoriteProducts, Product)
		}
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(favoriteProducts)
}

func getUserByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Users/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, user := range users {
		if user.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(user)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func updateUserHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/users/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedUser User
	err = json.NewDecoder(r.Body).Decode(&updatedUser)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, user := range users {
		if user.ID == id {
			users[i].Name = updatedUser.Name
			users[i].Image = updatedUser.Image
			users[i].Phone = updatedUser.Phone
			users[i].Mail = updatedUser.Mail

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)           // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)  // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)       // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler) // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler) // Удалить продукт

	http.HandleFunc("/cart", getCartHandler)             // Получить все продукты в корзине
	http.HandleFunc("/favourites", getFavoritesHandler)  // Получить избранные продукты
	http.HandleFunc("/users/", getUserByIDHandler)       // получить данные пользователя
	http.HandleFunc("/users/update/", updateUserHandler) // обновить данные пользователя

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}
