require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }

  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within("h2") do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "displays no items if a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items li").size).to eq(0)
  end

  it "displays item content when a todo list has items" do
    todo_list.todo_items.create(content: "Soy Milk")
    todo_list.todo_items.create(content: "Bread")

    visit_todo_list(todo_list)

    expect(page.all("table.todo_items tbody tr").size).to eq(2)

    within "table.todo_items" do
      expect(page).to have_content("Soy Milk")
      expect(page).to have_content("Bread")
    end

  end

end
