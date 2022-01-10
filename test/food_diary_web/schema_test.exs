defmodule FoodDiaryWeb.SchemaTest do
    use FoodDiaryWeb.ConnCase, async: true

    alias FoodDiary.User
    alias FoodDiary.Users

    describe "users query" do
        test "When a valid id is given, returns the user", %{conn: conn} do
            params = %{email: "mail@mail.com", name: "Mofo"}
            {:ok, %User{id: user_id}} = Users.Create.call(params)

            query = """
            {
                user(id: "#{user_id}"){
                    name,
                    email
                }
            }
            """

            expected_response =  %{"data" => %{"user" => %{"email" => "mail@mail.com", "name" => "Mofo"}}}
            response =
                conn
                |> post("api/graphql", %{query: query})
                |> json_response(:ok)

            assert response == expected_response
        end
    end
end
