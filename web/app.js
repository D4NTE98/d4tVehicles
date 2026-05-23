const app = document.getElementById('app')
const vehiclesBox = document.getElementById('vehicles')
const garageName = document.getElementById('garageName')

let payload = null

function post(name, data) {
    if (typeof GetParentResourceName !== 'function') {
        console.log(name, data || {})
        return
    }

    fetch(`https://${GetParentResourceName()}/${name}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data || {})
    })
}

function pct(value, max) {
    return Math.max(0, Math.min(100, Math.floor((Number(value || 0) / max) * 100)))
}

function render() {
    vehiclesBox.innerHTML = ''

    if (!payload) {
        return
    }

    garageName.textContent = payload.garageData.label

    payload.vehicles.forEach(vehicle => {
        const card = document.createElement('div')
        card.className = 'vehicle'

        const fuel = pct(vehicle.fuel, 100)
        const engine = pct(vehicle.engine, 1000)
        const body = pct(vehicle.body, 1000)

        card.innerHTML = `
            <div>
                <strong>${vehicle.model}</strong>
                <span>${vehicle.plate} · ${vehicle.state} · ${Number(vehicle.mileage || 0).toFixed(1)} km</span>
            </div>
            <div class="bars">
                <span>Fuel ${fuel}%</span>
                <span>Engine ${engine}%</span>
                <span>Body ${body}%</span>
            </div>
            <button>${vehicle.state === 'out' ? 'Outside' : 'Spawn'}</button>
        `

        card.querySelector('button').addEventListener('click', () => {
            if (vehicle.state !== 'out') {
                post('spawn', {
                    garage: payload.garage,
                    plate: vehicle.plate
                })
            }
        })

        vehiclesBox.appendChild(card)
    })
}

document.getElementById('close').addEventListener('click', () => {
    app.classList.add('hidden')
    post('close')
})

document.getElementById('refresh').addEventListener('click', () => {
    if (payload) {
        post('refresh', {
            garage: payload.garage
        })
    }
})

window.addEventListener('message', event => {
    const data = event.data

    if (data.action === 'open') {
        payload = data.payload
        app.classList.remove('hidden')
        render()
    }

    if (data.action === 'close') {
        app.classList.add('hidden')
    }

    if (data.action === 'notify') {
        console.log(data.message)
    }
})
