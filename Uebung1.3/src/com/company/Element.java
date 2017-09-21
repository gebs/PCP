package com.company;

public class Element {
    private int value;
    private Element element;

    public Element(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public Element getNext() {
        return element;
    }

    public void setNext(Element next) {
        this.element = next;
    }
}
