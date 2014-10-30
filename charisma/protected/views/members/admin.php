<?php
//$model = new Members;
$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	Yii::t('app', 'Manage'),
);
?>

<h3><?php echo Yii::t('app', 'Manage') . ' ' . GxHtml::encode($model->label(2)); ?></h3>
<hr/>
<?php
$this->menu = array(
		array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
		array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('members-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('admin'), 'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'linkOptions'=>array()),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	    array('label'=>'Reports', 'icon'=>'icon-download', 'url'=>'index.php?r=memberReport', 'linkOptions'=>array()),
	),
));
$this->endWidget();
?>



<?php echo GxHtml::link(Yii::t('app', 'Advanced Search'), '#', array('class' => 'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search', array(
	'model' => $model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'members-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'cardnumber',
		'title',
		'firstname',
		'middlename',
		'lastname',
		'issuedate',
		'expireddate',
		'birthday',
	    array(
        'name'=>'sex',
        'value'=>'Members::getSex($data->sex)',
        'filter'=>CHtml::listData(Members::getSexs(), 'id', 'sex'),
        ),
		array(
        'name'=>'type',
        'value'=>'Members::getType($data->type)',
        'filter'=>CHtml::listData(Members::getTypes(), 'id', 'type'),
        ),
		array(
        'name'=>'status',
        'value'=>'Members::getStatus($data->status)',
        'filter'=>CHtml::listData(Members::getStatuss(), 'id', 'status'),
        ),
       /* 'email',
		'phonenumber',
		'address',
		'nationality',
		
		
		'photo',
		*/
	

    array(
            'class'=>'CButtonColumn',
      'template' => '{view} {create}',
      'buttons' => array(
            'view' => array(
          'label'=> 'View',
          'url'=>'Yii::app()->createUrl("members/view", array("id"=>$data->id))',
           'options'=>array(
           'class'=>'btn btn-small view'
          )
        ),  
                
          'create' => array(
          'label'=> 'Formulaire',
          
          'url'=>'Yii::app()->createUrl("members/formulaire", array("id"=>$data->id))',
          'imageUrl'=>'../charisma/images/add.png',
           'options'=>array(
           'class'=>'btn btn-small view',
           'style'=>'width:115'
          )
        ), 
      ),
        'htmlOptions'=>array('style'=>'width: 100px'),
           )
	),
)); ?>