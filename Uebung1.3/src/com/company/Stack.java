package com.company;

import java.util.ArrayList;
import java.util.List;

public class Stack {
    //ArrayList<Element> mystack = new ArrayList<Element>();
    Element top;
    int CURRENT_INDEX;
    Element EMPTY_ELEMENT = new Element(-1111111);


    public void Stack() {
        CURRENT_INDEX = 0;
    }

    public void push(Element e) {

        e.setNext(top);
        top = e;

        CURRENT_INDEX++;
    }

    public Element top() {
        if (top != null)
            return top;
        else
            return EMPTY_ELEMENT;
    }

    public boolean pop() {
        if (top != null) {
            top = top.getNext();
            CURRENT_INDEX--;
            return true;
        }else
        {
            return  false;
        }
    }

    public void print() {
        if (top != null){
            System.out.print("print - Stack contains: ");
            System.out.print(top.toString() + " ");
            System.out.print("top element = " + top().getValue() + "\n");
        }else{
            System.out.print("print - Stack is empty\n");
        }
    }

    public boolean isEmpty() {
        return top == null;
    }

    public int size() {
        return CURRENT_INDEX;
    }
}
