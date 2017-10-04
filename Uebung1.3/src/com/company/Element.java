package com.company;

public class Element {
    private int value;
    private Element next;

    public Element(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public Element getNext() {
        return next;
    }

    public void setNext(Element next) {
        this.next = next;
    }

    @Override
    public String toString() {
        if (next == null)
            return this.value + "";
        else
            return this.value + " " +  next.toString();

    }
}
