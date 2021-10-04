/*
 * Click `Run` to execute the snippet below!
 */

import java.io.*;
import java.util.*;

class Solution {

    static class Input { 
        Character exchangeIndex; 
        int bookIndex; 
        String operation;  // New, Update, Delete  
        String side; // Bid or offer

        int price; 
        int quantity; 
        public Input(Character exchangeIndex, int bookIndex, String operation, String side, int price, int quantity) { 
            this.exchangeIndex = exchangeIndex;
            this.bookIndex = bookIndex; 
            this.operation = operation;
            this.side = side;
            this.price = price; 
            this.quantity = quantity; 
        }
    }


    static class Exchange { 
        // Book Index, Offer Quanity 
        Character exchangeIndex; 
        HashMap<Integer, Book> offerBooks = new HashMap<>();
        HashMap<Integer, Book> bidBooks = new HashMap<>(); 

        public Exchange(Character exchangeIndex) {
            this.exchangeIndex = exchangeIndex;
        }
    }


    static class Book { 
        int quantity;
        int price; 

        public Book(int quantity, int price) {
            this.quantity = quantity; 
            this.price = price;
        }
    }


    public static void main(String[] args) {
        
        // String exchangeIndex, int bookIndex, String operation, String side, int price, int quantity) {
        Input one = new Input('A', 0, "NEW", "BID", 100, 75); 
        Input two = new Input('A', 1, "NEW", "BID", 99, 100);
        Input three = new Input('A', 0, "NEW", "OFFER",102, 88); 
        
        Input[] inputs = new Input[] { one, two, three };
        HashMap<Character, Exchange> result = Solution.solution(inputs);        
    }
    
    public static HashMap<Character, Exchange> solution(Input[] inputs) { 
        HashMap<Character, Exchange> map = new HashMap<>();
        HashMap<Integer, Book> books;  
        Exchange exchange; 
        
        for (Input input : inputs) {
            
            System.out.println(input.exchangeIndex);
            
            exchange = map.getOrDefault(input.exchangeIndex, new Exchange(input.exchangeIndex)); 
            
            if (map.containsKey(input.exchangeIndex)) { 
                System.out.println("Yes");
            }
            
            
            
            if (input.side == "BID") { 
                books = exchange.bidBooks;
            } else { //  if (input.side == "OFFER" 
                books = exchange.offerBooks; 
            } 
            
            
            if (input.operation == "NEW") { 
                books.put(input.bookIndex, new Book(input.quantity, input.price));
            }
                        
             
            if (input.operation == "UPDATE") { 
                if (books.containsKey(input.bookIndex)) { 
                    Book book = books.get(input.bookIndex); 
                    book.quantity = input.quantity;
                }
            } 
                          
            if (input.operation == "DELETE") { 
                books.remove(input.bookIndex);
            }
        }
         return map;
    }
}
