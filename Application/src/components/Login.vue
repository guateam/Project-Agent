<template>
    <v-form>
        <v-container>
            <v-layout row wrap>
                <v-flex xs12 sm12 md12>
                    <v-text-field
                            label="邮箱"
                    ></v-text-field>
                </v-flex>
                <v-flex xs12 sm12 md12>
                    <v-text-field
                            v-model="password"
                            :append-icon="show1 ? 'visibility_off' : 'visibility'"
                            :rules="[rules.required, rules.min]"
                            :type="show1 ? 'text' : 'password'"
                            name="password"
                            label="密码"
                            hint="At least 8 characters"
                            counter
                            @click:append="show1 = !show1"

                    ></v-text-field>
                </v-flex>
                <v-flex xs12 sm12 md12>
                    <v-btn color="info">登录</v-btn>
                </v-flex>
            </v-layout>
        </v-container>
    </v-form>
</template>

<script>
    export default {
        name: "Login"
    }
</script>

<style scoped>

</style>
