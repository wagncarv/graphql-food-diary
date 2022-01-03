defmodule FoodDiaryWeb.Resolvers.Meal do
    alias FoodDiary.Meals

    def create(%{input: params}, _context) do
        Meals.Create.call(params)
    end
end
