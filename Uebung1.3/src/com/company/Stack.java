package com.company;

import java.util.ArrayList;
import java.util.List;

public class Stack {
    ArrayList<Element> mystack = new ArrayList<Element>();
    int CURRENT_INDEX;
    Element EMPTY_ELEMENT = new Element(-1111111);


    public void Stack() {
        CURRENT_INDEX = 0;
    }

    public void push(Element e) {
        mystack.add(e);

        if (CURRENT_INDEX > 0)
            mystack.get(CURRENT_INDEX - 1).setNext(e);

        CURRENT_INDEX++;
    }

    public Element top() {
        if (CURRENT_INDEX > 0) {
            return mystack.get(CURRENT_INDEX - 1);
        } else {
           // System.out.println("ERROR - top: stack empty!");
            return EMPTY_ELEMENT;
        }
    }

    public boolean pop() {
        if (CURRENT_INDEX > 0) {
            mystack.remove(CURRENT_INDEX - 1);
            CURRENT_INDEX--;
            return true;
        } else {
            return false;
        }

    }

    public void print() {
        if (mystack.size() > 0) {
            System.out.print("print - Stack contains: ");
            for (int i = CURRENT_INDEX - 1; i > -1; i--) {
                System.out.print(mystack.get(i).getValue() + ", ");
            }
            System.out.print("top element = " + top().getValue() + "\n");
        } else {
            System.out.print("print - Stack is empty\n");
        }
    }

    public boolean isEmpty() {
        return CURRENT_INDEX == 0;
    }

    public int size() {
        return CURRENT_INDEX;
    }
}
