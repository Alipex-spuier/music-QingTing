<template>
	<view>
		<img class="avatar" v-for="imgSrc in imgList" :src="imgSrc" :alt="'Image' + imgSrc" :key="imgSrc" @click="chooseAvatar(imgSrc)"/>
	</view>
</template>

<script>
	export default {
		created(){
			const user = uni.getStorageSync("res");
			this.authorization = user.header.authorization;
			this.userId = user.data.data.userId;
		},
		data() {
			return {
				imgList: Array.from({
					length: 151
				}, (v, k) => this.$basePhotoURL+`/avatar/${k + 1}.png`),
				avatar:null,
				authorization:null
			}
		},
		methods: {
			getAllMusic() {
				uni.request({
					url: this.$baseURL + '/music/getAllMusic',
					method: 'GET',
					success: (response) => {
						const res = response.data;
						uni.setStorageSync("allMusic", res);
					}
				});
			},
			chooseAvatar(item){
				this.getAllMusic();
				uni.request({
					url: this.$baseURL + '/user/update',
					method: 'PUT',
					header: {
						Authorization: this.authorization
					},
					data: {
						avatar:item,
						userId:this.userId
					},
					success: res => {
						if (res.data.code === 200) {
							this.getNewData();
							uni.showToast({
								title: '修改成功',
								success: function() {
									setTimeout(function() {
										uni.navigateTo({
											url: '/pages/index'
										})
									}, 2000)
								}
							});
						} else {
							uni.showToast({
								title: '修改失败：' + res.data.msg,
								icon: 'none'
							});
						}
					},
					fail: () => {
						uni.showToast({
							title: '网络请求失败',
							icon: 'none'
						});
					}
				});
			},
			getNewData() {
				const _this = this;
				uni.request({
					url: this.$baseURL + '/user/index/' + _this.userId,
					method: 'POST',
					header: {
						Authorization: _this.authorization
					},
					success: res => {
						if (res.data.code == 200) {
							uni.clearStorageSync("res")
							res.header.authorization = _this.authorization
							uni.setStorageSync("res", res)
						}
					}
				})
			},
		}
	}
</script>

<style>
	.avatar{
		width: 20%;
		height: 20%;
	}
	.avatar:active{
		opacity: 0.7;
	}
</style>