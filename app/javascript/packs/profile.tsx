// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import * as Yup from "yup"
import { Formik, Form, Field, ErrorMessage } from "formik"
import tw, { styled } from "twin.macro"

const Hello = props => (
  <div>Hello {props.name}!</div>
)

const FieldWrapper = styled.div`
  ${tw`mb-4`}
`

interface User {
  id: number
  email: string
  username: string
  password: string
}

interface Props {
  user: User
}

function ProfileForm({ user }: Props) {
  const [initialValues, setInitialValues] = React.useState<User>(user)

  const validationSchema = Yup.object().shape({
    email: Yup.string().email().required(),
    password: Yup.string().min(8),
    username: Yup.string().required(),
  })

  return (
    <Formik
      initialValues={initialValues}
      enableReinitialize
      validationSchema={validationSchema}
      onSubmit={(values, { setSubmitting, resetForm }) => {
        setSubmitting(true)
        const authToken = (document.querySelector('meta[name="csrf-token"]') as any).content
        fetch(`/profile`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: JSON.stringify({
            authenticity_token: authToken,
            user: {
              email: values.email,
              password: values.password,
              username: values.username,
            }
          })
        }).then((res) => {
          if (res.status === 200) {
            alert("Profile updated")
            setInitialValues({...values, password: ""})
            resetForm({ values: initialValues })
          } else {
            alert("Error in updating the profile")
          }
          setSubmitting(false)
        }).catch((e) => {
          alert(e)
          setSubmitting(false)
        })
      }}>
        {(form) => (
          <Form method="post" action="/profile">
            <div className="form-group">
              <Field name="email">
                {({field}) => (
                  <FieldWrapper>
                    <label htmlFor="email">Email</label>
                    <input type="email" {...field} id="email" disabled />
                  </FieldWrapper>
                )}
              </Field>
              <ErrorMessage name="email" component="p" className="error" />

              <Field name="password">
                {({field, meta}) => (
                  <FieldWrapper>
                    <label htmlFor="password">Password</label>
                    <input type="password" {...field} id="password" />
                    {meta.touched && meta.error && (
                      <ErrorMessage name="password" component="p" className="error" />
                    )}
                  </FieldWrapper>
                )}
              </Field>

              <Field name="username">
                {({field, meta}) => (
                  <FieldWrapper>
                    <label htmlFor="username">Username</label>
                    <input type="text" {...field} id="username" />
                    {meta.touched && meta.error && (
                      <ErrorMessage name="username" component="p" className="error" />
                    )}
                  </FieldWrapper>
                )}
              </Field>

              <div className="flex items-center justify-between">
                <input type="submit"
                  onClick={form.submitForm}
                  value="Save changes"
                  className="cta-btn w-full"
                  disabled={form.isSubmitting || !form.isValid}/>
              </div>
            </div>
          </Form>
        )}
    </Formik>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const placeholderElm = document.getElementById("renderable")
  const userData: User = JSON.parse(placeholderElm.getAttribute("data-user"))
  userData.password = ""

  ReactDOM.render(
    <ProfileForm user={userData} />,
    placeholderElm
  )
})
